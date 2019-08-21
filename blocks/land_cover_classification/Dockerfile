### Dockerfile to build the UP42 usage tutorial with land coverage
### classification using clustering.

# Use one of the official Tensorflow Docker images as base.
FROM tensorflow/tensorflow:1.13.1-py3

ARG BUILD_DIR=blocks/land_cover_classification

# The manifest file contains metadata for correctly building and
# tagging the Docker image. This is a build time argument.
ARG manifest
LABEL "up42_manifest"=$manifest


# Working directory setup.
WORKDIR /block
COPY $BUILD_DIR/requirements.txt /block

# Install trhe Python requirements.
RUN pip install -r requirements.txt

# Copy the code into the container.
COPY $BUILD_DIR/src /block/src

# Invoke run.py.
CMD ["python", "/block/src/run.py"]
