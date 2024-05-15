# Use the NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

RUN apt-get update && apt-get install -y wget git

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.10.0-1-Linux-x86_64.sh
RUN bash Miniconda3-py310_23.10.0-1-Linux-x86_64.sh -b -u

RUN . /root/miniconda3/etc/profile.d/conda.sh
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN echo "source /root/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc

# RUN conda create -y --name dpo python=3.9
COPY environment.yaml .
RUN conda env create -f environment.yaml

SHELL ["conda", "run", "-n", "dpo", "/bin/bash", "-c"]
RUN echo "conda activate dpo" >> ~/.bashrc && \
    pip install accelerate
    # pip install transformers datasets accelerate flash_attn && \
    # pip install -i https://pypi.org/simple/ bitsandbytes

WORKDIR /workspace

CMD ["bash"]
