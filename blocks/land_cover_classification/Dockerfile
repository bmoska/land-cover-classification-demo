# Use one of the official Tensorflow Docker images as a base
FROM tensorflow/tensorflow:1.13.1-py3

# The manifest file contains metadata for correctly building and tagging the Docker image
ARG manifest
LABEL "up42_manifest"=$manifest

# Create the home directory of the operation
WORKDIR /block
COPY requirements.txt /block

# Install Python requirements
RUN pip install -r requirements.txt

# Copy the code into the container
COPY src /block/src

# Set the main entry point of the container to run.py
CMD ["python", "/block/src/run.py"]
