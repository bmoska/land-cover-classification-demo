## Include the configuration. 
include config.mk

VALIDATE_ENDPOINT := https://api.up42.com/validate-schema/block
REGISTRY := registry.up42.com
CURL := curl
DOCKER := docker

build: $(MANIFEST_JSON)
ifdef UID
	$(DOCKER) build --build-arg manifest="$$(cat $<)" -f $(UP42_DOCKERFILE) -t $(REGISTRY)/$(UID)/$(DOCKER_TAG) .
else
	$(DOCKER) build --build-arg manifest="$$(cat $<)" -f $(UP42_DOCKERFILE) -t $(DOCKER_TAG) .
endif

validate: $(MANIFEST_JSON)
	$(CURL) -X POST -H 'Content-Type: application/json' -d @$^ $(VALIDATE_ENDPOINT) 

push:
	$(DOCKER) push $(REGISTRY)/$(UID)/$(DOCKER_TAG)

login:
	$(DOCKER) login -u $(USER) https://$(REGISTRY)

install:
	cd $(SRC) && ./setup.sh && cd $(CURDIR)
test: 
	cd $(SRC) && ./test.sh && cd $(CURDIR)

run: build
	$(call create_job_config ,$(JOB_CONFIG))
	(DOCKER) run -e UP42_TASK_PARAMETERS="$$(cat $(JOB_CONFIG))" $(DOCKER_RUN_OPTIONS) $(DOCKER_TAG) 	

.PHONY: build login push test install run

