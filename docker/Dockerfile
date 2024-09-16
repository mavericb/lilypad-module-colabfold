# Use NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 AS builder

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

# Download ColabFold weights at build time
RUN python3 -c "from colabfold.download import default_data_dir; from colabfold.utils import setup_logging; setup_logging(); from colabfold.download import download_alphafold_params; download_alphafold_params(default_data_dir)"

# Setup MMseq2 database
RUN mkdir -p /database && \
    wget https://github.com/soedinglab/MMseqs2/releases/download/13-45111/uniref30_2202_db.tar.gz && \
    tar -xzvf uniref30_2202_db.tar.gz -C /database && \
    rm uniref30_2202_db.tar.gz

# Copy application files
COPY Dockerfile /app/Dockerfile
COPY main.py /app/main.py
COPY start.sh /app/start.sh

RUN ls -la /app

# Make start.sh executable
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]