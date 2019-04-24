# Land Cover Classification

## General information

* Block type: processing
* Supported input types:
  * AOIClipped (any georeferenced GeoTIFF)
* Provider: UP42
* Tags: machine learning, data processing, analytics, land cover

## Description
This is a simple, proof-of-concept unsupervised land cover classification algorithm that serves demoing purposes but is not meant in any way to provide reliable results. It is educational as it shows how a land cover classification can be done on the UP42 platform and could be used as a starting point for more rigorous algorithms. It is based on TensorFlow for the same reason: the code can be used as a template for more sophisticated algorithms.

## Usage

### Local Development
Below you can find instructions on how to work on this processing block.

#### Working with the code on a dev machine
The code base of this processing block is written in Python 3.5. The Python packages required to make it work locally are located in `blocks/land_cover_classification/requirements.txt`. You can install these packages on your machine or a virtualenv to get started with development.

#### Running the tests
This project uses Pytest as it's test runner, you can use the following shell command from the root of the repository to run the tests: `. blocks/land_cover_classification/test.sh`.

#### Building the Docker image for the processing block
To build the Docker image for local testing or publishing on the UP42 platform you can run the following shell command from the root of this repository: `cd blocks/land_cover_classification/; docker build -t land_cover_classification -f Dockerfile . --build-arg manifest="$(cat UP42Manifest.json)"; cd -`.

#### Running the processing block in a Docker container
To try the processing block on your local development machine in a production-like environment you need the following things:

   * Create the block's input directory `/tmp/input` and output directory `/tmp/output`
   * Copy the input data (along with the GeoJSON file called `data.json`) to `/tmp/input`
   * Build the docker image as outlined above
   * Run the following command: `docker run -v /tmp/output:/tmp/output -v /tmp/input:/tmp/input land_cover_classification:latest`

After this if everything went well the output of the processing block is available in `/tmp/output`.

### Publishing

For detailed info on publishing a block please check the UP42 documentation.

You can push your block as a Docker image to the UP42 registry like this: `docker push registry.up42.com/<user_id>/land_cover_classification:latest`.

### Further resources

   * [Getting started with UP42](https://docs.up42.com/getting-started/index.html)
   * [Creating a block](https://docs.up42.com/getting-started/first-block.html)
   * [Setting up the development environment](https://docs.up42.com/getting-started/dev-setup.html)
   * [Block specifications](https://docs.up42.com/specifications/index.html)
   * [Block examples](https://docs.up42.com/examples/index.html)
   * [Tensorflow](https://www.tensorflow.org/)
