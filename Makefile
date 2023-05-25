# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
PROJECT_MKFILE_PATH     := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_MKFILE_DIR      := $(shell cd $(shell dirname $(PROJECT_MKFILE_PATH)); pwd)

PROJECT_ROOT            		:= $(PROJECT_MKFILE_DIR)
PROJECT_NAME					:= docker-on-debian
PROJECT_VERSION					:= 23


.PHONY: build-cli
build-cli: TAG=$(PROJECT_NAME):$(PROJECT_VERSION)-cli
build-cli:
	docker build									\
		--platform	linux/amd64						\
		--tag      	$(TAG)							\
		--file     	$(PROJECT_ROOT)/cli/Dockerfile	\
		$(PROJECT_ROOT)/cli
	# uncomment to build ARM/Mac compliant
	#	docker build									\
	#		--platform	linux/arm64						\
	#		--tag      	$(TAG)							\
	#		--file     	$(PROJECT_ROOT)/cli/Dockerfile	\
	#		$(PROJECT_ROOT)/cli

.PHONY: build-dind
build-dind: TAG=$(PROJECT_NAME):$(PROJECT_VERSION)-dind
build-dind: build-cli

