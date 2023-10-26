# Use an official Miniconda3 base image
FROM continuumio/miniconda3

# Set environment variables for non-interactive conda installation
ENV CONDA_AUTO_UPDATE_CONDA=false \
    CONDA_DEFAULT_ENV=base \
    CONDA_CHANNELS=defaults \
    CONDA_CHANNEL_PRIORITY=false \
    CONDA_PIP_INTEROP_ENABLED=true \
    PATH=/opt/conda/bin:$PATH

# Update conda and install essential tools including Samtools
RUN conda update --yes -n base -c defaults conda && \
    conda install --yes -c conda-forge -c bioconda make samtools zlib

# Use an official base image with Linux as the OS
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    tar \
    build-essential \
    zlib1g-dev  # Install the zlib development package

# Create a directory for your application
WORKDIR /app

# Clone the XCVATR repository from GitHub
RUN git clone https://github.com/harmancilab/XCVATR.git

# Change the working directory to the XCVATR repository
WORKDIR /app/XCVATR

# Define the entry point for your application
ENTRYPOINT ["/app/XCVATR/bin/XCVATR"]
