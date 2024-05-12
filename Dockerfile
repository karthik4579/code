# Use the latest Ubuntu LTS as the base image
FROM ubuntu:latest

# Switch back to root user
USER root

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]
ENV test $PASSWORD

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python-is-python3 \
    openjdk-11-jdk \
    curl \
    wget \
    zip \
    unzip \
    sudo \
    git \
    vim \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | bash

# Create a new user 'perceptr' and add it to the root group
RUN useradd -m perceptr -G root

# Set the bind address for code-server
CMD code-server --bind-addr 0.0.0.0:8080

# Switch to the 'perceptr' user
USER perceptr
