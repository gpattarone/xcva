# Use an official base image with Linux as the OS
FROM ubuntu:latest

# Install Git and other required dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    tar \
    build-essential

# Create a directory for your application
WORKDIR /app

# Clone the XCVATR repository from GitHub
RUN git clone https://github.com/harmancilab/XCVATR.git

# Change the working directory to the XCVATR repository
WORKDIR /app/XCVATR

# Build the XCVATR application
RUN make clean && make

# Install "samtools"
WORKDIR /app

RUN wget https://sourceforge.net/projects/samtools/files/latest/download?source=files && \
    tar -xvjf "download?source=files" && \
    samtools_dir=$(find . -name 'samtools-*' | xargs -Ifiles basename files) && \
    cd ${samtools_dir} && \
    ./configure --without-curses --disable-lzma && \
    make clean && make && make install

# Define the entry point for your application
ENTRYPOINT ["/app/XCVATR/bin/XCVATR"]
