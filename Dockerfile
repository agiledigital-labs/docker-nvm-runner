FROM debian:stable-slim

LABEL Description="Docker image with will install any node version via nvm with provided argument" Vendor="Agile Digital" Version="0.1"

# use bash
SHELL ["/bin/bash", "--login", "-c"]

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# run script on startup
COPY ./nvm-installer.sh /
ENTRYPOINT ["/nvm-installer.sh"]

