# Use NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y curl python3 python3-pip git libgl1-mesa-glx libglib2.0-0 wget && \
    rm -rf /var/lib/apt/lists/*

# Install MMseq2
RUN wget https://github.com/soedinglab/MMseqs2/releases/latest/download/mmseqs-linux-avx2.tar.gz && \
    tar xvzf mmseqs-linux-avx2.tar.gz && \
    mv mmseqs/bin/* /usr/local/bin/ && \
    rm -rf mmseqs mmseqs-linux-avx2.tar.gz

# Install ColabFold
RUN pip3 install "colabfold[alphafold] @ git+https://github.com/sokrypton/ColabFold"

# Setup MMseq2 database
RUN mkdir -p /database && \
    cd /database && \
    wget https://www.dropbox.com/s/dge2wsqdclryfxd/uniref.tar.gz && \
    tar -xzvf uniref.tar.gz && \
    rm uniref.tar.gz

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]