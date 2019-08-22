# Land Cover Classification

## General information

* Block type: processing
* Supported input types: up42.data.aoiclipped
* Provider: [UP42](https://up42.com)
* Tags: machine learning, data processing, analytics, land cover

## Description

This is a simple instructional proof-of-concept [unsupervised learning](https://en.wikipedia.org/wiki/Cluster_analysis)
[land cover](https://en.wikipedia.org/wiki/Land_cover)
classification algorithm that provides a very simple demo of what is
possible to do using UP42.

The goal of this project is to guide you through setting UP42 in your
geospatial pipeline. It shows how easy it is to setup a clustering
algorithm implemented in [TensorFlow](https://tensorflow.org) to
perform land cover classification.

It functions as an example processing block.

### Inputs & outputs

This block takes as input any [AOI clipped](https://docs.up42.com/specifications/capabilities.html?highlight=aoi%20clipped#built-in-capabilities)
geo-referenced [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF))

The output is a [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) file.

### Block capabilities

The block takes a `up42.aoiclipped` input
[capability](https://docs.up42.com/specifications/capabilities.html)
and delivers a [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) file.

## Requirements

 1. [docker](https://docs.docker.com/install/).
 2. [GNU make](https://www.gnu.org/software/make/).
 3. [Python](https://python.org/downloads): version >= 3.7 &mdash; only
    for [local development](#local-development). 

## Usage

### Clone the repository

```bash
git clone https://github.com/up42/land-cover-classification-demo.git <directory>
``` 

where `<directory>` is the directory where the cloning is done.

### Build the docker image

For building the image you should tag the image such that it can bu
pushed to the UP42 docker registry, enabling you to run it as a custom
block. For that you need to pass your user ID (UID) in the `make`
command.

The quickest way to get that is just to go into the UP42 console and
copy & paste from the last clipboard that you get at the
[custom-blocks](https://console.up42.com/custom-blocks) page and after
clicking on **PUSH a BLOCK to THE PLATFORM**. For example, it will be
something like:

```bash
docker push registry.up42.com/<UID>/<image_name>:<tag>
```

Now you can launch the image building using `make` like this:

```bash
make build UID=<UID>
```

You can avoid selecting the exact UID by using `pbpaste` in a Mac (OS
X) or `xsel --clipboard --output` in Linux and do:

```bash
# mac: OS X.
make build UID=$(pbpaste | cut -f 2 -d '/')

# Linux.
make build UID=$(xsel --clipboard --output | cut -f 2 -d '/') 
```

You can additionaly specifiy a custom tag for your image (default tag
is `snap-polarimetric:latest`):

```bash
make build UID=<UID> DOCKER_TAG=<docker tag>
```

if you don't specify the docker tag, it gets the default value of `latest`.

### Push the image to the UP42 registry

You first need to login into the UP42 docker registry.

```bash
make login USER=me@example.com
```

where `me@example.com` should be replaced by your username, which is
the email address you use in UP42.

Now you can finally push the image to the UP42 docker registry:

```bash
make push UID=<UID>
```

where `<UID>` is user ID referenced above. Again using the copy &
pasting on the clipboard.

```bash
# mac: OS X.
make build UID=$(pbpaste | cut -f 2 -d '/')

# Linux.
make build UID=$(xsel --clipboard --output | cut -f 2 -d '/') 
```
```bash
make push UID=<UID>
```
Note that if you specified a custom docker tag when you built the image, you
need to pass it now to `make`.

```bash
make push UID=<UID> DOCKER_TAG=<docker tag>
```

where `<UID>` is user ID referenced above. Again using the copy &
pasting on the clipboard.

```bash
# mac: OS X.
make build UID=$(pbpaste | cut -f 2 -d '/') DOCKER_TAG=<docker tag>

# Linux.
make build UID=$(xsel --clipboard --output | cut -f 2 -d '/') DOCKER_TAG=<docker tag>
```

After the image is pushed you should be able to see your custom block
in the [console](https://console.up42.dev/custom-blocks/) and you can
now use the block in a workflow.

### Run the processing block locally

#### Configure the job

To run the docker image locally you might need first to configure the
job with the parameters specific to this block. If you are not happy
with the provided defaults. 

`params.json` like this:

```js
{
    n_clusters": <number of clusters>,
    n_iterations": <number of iterations>,
    n_sieve_pixels: <number of pixels>
}
```
where:

+ `<number of clusters>`: number of clusters for the K-means
  clustering &mdash; default 6.
+ `<number of iterations>`: number of iterations for the K-means
  clustering &mdash; defaul 10
+ `<number sieve pixels>`: minimum number of pixels in each patch for
  the classification &mdash; default 64

Here is an example `params.json`:

```js
{
  "n_clusters": 10,
  "n_iterations": 12,
  "n_sieve_pixels": 128,
}
```

#### Get the data

The required AOI clipped image  can be
obtained by creating a workflow with a single data block with `up42.data.aoiclipped`
data block and download the the result.

Then create the directories `/tmp/input/` and `/tmp/output`:

```bash
mkdir /tmp/input
mkdir /tmp/output

```

Now untar the tarball with the result in that directory:

```bash
tar -C /tmp/input -zxvf <downloaded tarball>
```
#### Run the block

```bash
make run
```
 
If set a custom docker tag then the command ro run the block is:

```bash
make run DOCKER_TAG=<docker tag>
```

### Local development
 
#### Install the required libraries

First create a virtual environment either by using [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) 
or [virtualenv](https://virtualenv.pypa.io/en/latest/).

In the case of using virtualenvwrapper do:

```bash
mkvirtualenv -p $(which python3.7) up42-landcover
```

In the case of using virtualenv do:

```bash
virtualenv -p $(which python3.7) up42-landcover
```

After creating a virtual environment and activating it, all the necessary libraries can be installed on this environment by doing:

```bash
make install
```

#### Run the tests

This project uses [pytest](https://docs.pytest.org/en/latest/) for
testing.  To run the tests, first create two empty `/tmp/input/` and
`/tmp/output` directories. The output will be written to the
`/tmp/output/` directory.  Finally, to run the test do as following:

```bash
make test
```

Now you need to [build](#build-the-docker-images) and 
[run](#run-the-processing-block-locally) the block locally.

### Support
  
 1. Open an issue here.
 2. Reach out to us on
      [gitter](https://gitter.im/up42-com/community).
 3. Mail us [support@up42.com](mailto:support@up42.com).
