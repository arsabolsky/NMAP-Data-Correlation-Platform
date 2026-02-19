# FROM: Specifies the "Base Image". We start with a pre-configured 
# Python 3.12 environment provided by Microsoft for Dev Containers.
FROM mcr.microsoft.com/devcontainers/python:3.12

# Install 'uv'
# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Add 'uv' to the system PATH
ENV PATH="/root/.local/bin:$PATH"

# Define the working directory inside the container
WORKDIR /workspaces/NMAP-Data-Correlation-Platform

# Copy project files
COPY . .

# Install dependencies using uv
# We remove --frozen here to allow uv to resolve any minor environment differences
RUN uv sync
