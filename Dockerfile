# base image
FROM conda/miniconda3
RUN apt update -y  && apt install -y build-essential && apt-get install -y  build-essential
RUN apt-get install -y vim && apt-get install -y wget

# work directory
RUN mkdir /smi2qm
WORKDIR /smi2qm
ADD . /smi2qm/

# install XTB
RUN wget https://github.com/grimme-lab/xtb/releases/tag/v6.4.1/xtb-6.4.1-linux-x86_64.tar.xz
RUN tar xfv xtb-6.4.1-linux-x86_64.tar.xz
RUN rm -f xtb-6.4.1-linux-x86_64.tar.xz
RUN alias xtb='/smi2qm/xtb-6.4.1/bin/xtb'

# create Conda environment from yaml file listing all relevant packages:
RUN conda env create -f environment.yaml

# run image
ENTRYPOINT ["conda", "run", "-n", "smi2qm", "python", "/smi2qm/smi2qm/main.py"]

