FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04


RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim \
    sudo \
    build-essential
WORKDIR /opt

RUN wget https://github.com/conda-forge/miniforge/releases/download/25.3.1-0/Miniforge3-25.3.1-0-Linux-x86_64.sh && \
#RUN curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    git clone +https://github.com/YDS-Pharmatech/FKSFold-Chai.git && \
    sh Miniforge3-25.3.1-0-Linux-x86_64.sh -b -p /opt/Miniforge && \    
    rm -r Miniforge3-25.3.1-0-Linux-x86_64.sh
    
ENV PATH /opt/Miniforge/bin:$PATH
WORKDIR /opt/FKSFold-Chai
RUN conda create -n fksfold_chai python=3.12 -y && \
    conda init
    
SHELL ["conda", "run", "-n", "fksfold_chai", "/bin/bash", "-c"]

RUN pip install git+https://github.com/YDS-Pharmatech/FKSFold-Chai.git && \
    echo "conda activate fksfold_chai" >> ~/.bashrc

ENV PATH /opt/Miniforge/envs/fksfold_chai/bin:$PATH
