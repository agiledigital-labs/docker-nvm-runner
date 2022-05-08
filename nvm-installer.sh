#!/bin/bash
# set node version with argument
if [ -z "${NODE_VER}" ]; then
  echo "No supplied node version, set with: ... -e NODE_VER='<version>' nvm ..."
  echo "Defaulting to long term support"
  export NODE_VER=--lts
fi

# ensure nvm is up to date and alias are set
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash > /dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" > /dev/null 2>&1 # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" > /dev/null 2>&1 # This loads nvm bash_completion

# install node with specified version
nvm install $NODE_VER > /dev/null
if [ $? -ne 0 ]; then
  echo "Failed to install node $NODE_VER"
  exit 1
else
  export NODE_VER=$(node -v)
  echo "Finished installing node $NODE_VER"
fi

# use installed node version
nvm alias default $NODE_VER
nvm use default

# add to path
export NODE_PATH=$NVM_DIR/$NODE_VER/lib/node_modules
export PATH=$NVM_DIR/versions/node/$NODE_VER/bin:$PATH

# install yarn globally
npm i -g --silent yarn > /dev/null 2>&1
YARN_VERSION=$(yarn -v)
echo "Installed yarn $YARN_VERSION"

if [ -z "$@" ]; then
  echo "No command supplied. To run interactively, use the following command: docker run -e NODE_VER='<version>' -it nvm bash"
fi

exec "$@"
