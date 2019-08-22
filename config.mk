## Configuration for Makefile.
SRC := blocks/land_cover_classification
MANIFEST_JSON := $(SRC)/UP42Manifest.json
UP42_DOCKERFILE := $(SRC)/Dockerfile
JOB_CONFIG := $(SRC)/params.json  
DOCKER_TAG := land-cover-classification
DOCKER_RUN_OPTIONS := --mount type=bind,src=/tmp/output,dst=/tmp/output --mount type=bind,src=/tmp/input,dst=/tmp/input

## If the job config file is missing create an empty one.
define create_job_config
	$(if $(wildcard $1),,$(shell echo '{}' > $1))
endef
