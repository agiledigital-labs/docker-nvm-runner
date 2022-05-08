# Docker `nvm`

* Specify any node version and the container will automatically install it using nvm. For example:

```bash
docker run -e NODE_VER='12.14.1' -it nvm bash
```

* If no version is specified, will use the current long term support version for node
* Also installs the latest version of yarn
* Specify version using an `.nvmrc`:

```bash
docker run -e NODE_VER="$(<.nvmrc)" -it nvm bash
```

Find on Docker Hub: <https://hub.docker.com/repository/docker/agiledigital/nvm>
