# Docker image for TravisCI <!-- omit in toc -->

[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/qnimbus/docker-travis-cli/master?style=for-the-badge)](https://www.github.com/QNimbus/docker-travis-cli) [![Travis (.org) branch](https://img.shields.io/travis/QNimbus/docker-travis-cli/master?style=for-the-badge)](https://travis-ci.org/github/QNimbus/docker-travis-cli) [![Docker Pulls](https://img.shields.io/docker/pulls/qnimbus/docker-travis-cli?style=for-the-badge)](https://hub.docker.com/repository/docker/qnimbus/docker-travis-cli)

- [Why](#why)
- [How to use](#how-to-use)
  - [Running simple travis commands](#running-simple-travis-commands)
  - [Running travis commands that require authentication](#running-travis-commands-that-require-authentication)
- [Extra](#extra)
- [TODO](#todo)
- [License](#license)

## Why

I needed to use the [Travis Client](https://github.com/travis-ci/travis.rb) command line utitlity to generate secure (encrypted) credentials for one of my projects. I did not want to install the client on my system along with the Ruby gem package manager so I decided to create a small docker container instead.

## How to use

Refer to [the documentation](https://github.com/travis-ci/travis.rb#readme) on how to use the travis client.

### Running simple travis commands

Pull the latest container image from Docker:

`$ docker pull qnimbus/docker-travis-cli`

*Optional:* Add tag to the image:

`$ docker tag qnimbus/docker-travis-cli travis-cli`

To run the container:

`$ docker run --rm travis-cli version`

To run the container and volume mount the `pwd`:

`$ docker run --rm --volume $(pwd):/travis travis-cli lint .travis.yml`   
`$ docker run --rm --volume $(pwd):/travis travis-cli status`

### Running travis commands that require authentication

- Ensure that you are in the correct working dir (the github repository you are working on)
- Start interactive session on the `travis-cli` container:  
  `$ docker run -it --rm --volume $(pwd):/travis --entrypoint /bin/sh travis-cli`
- Login to TravisCI:  
  *note: to generate a github token go to your [settings page](https://github.com/settings/tokens) with [certain permissions](https://docs.travis-ci.com/user/github-oauth-scopes/#travis-ci-for-open-source-and-private-projects)*
  ```bash
  /travis # travis login --org --github-token xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ```
- Perform commands as authenticated user:   
  ```bash
  /travis # travis whoami
  You are QNimbus (Bas)
  ```

  For example, to encrypt data:

  ```bash
  /travis # travis encrypt DOCKER_PASSWORD --add global.env
  ```

## Extra

To make using the Travis Client a bit easier from the command line you could create an alias, like so:

`$ alias travis-cli="docker run --rm --volume $(pwd):/travis travis-cli"`   
`$ alias travis-clii="docker run -it --rm --volume $(pwd):/travis --entrypoint /bin/sh travis-cli"`

This enables you to run:

`$ travis-cli status`

Or to start the interactive client:

`$ travis-clii`

```bash
/travis # 
```

To remove the aliases later on:

`$ unalias travis-cli travis-clii`

## TODO

- Create a shell script that will auto login using environment variables so you can run authenticated commands without having to use an interactive container.

## License

[MIT](LICENSE)