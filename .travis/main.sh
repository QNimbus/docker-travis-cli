#!/bin/bash

# Set an option to exit immediately if any error appears
set -o errexit

# Main function that describes the behavior of the script.
# By making it a function we can place our methods below and have the main execution described in a concise way via function invocations.
main() {
  setup_dependencies
  update_docker_configuration

  echo -e "SUCCESS:\nDone! Finished setting up Travis machine.\n"  
}

# We upgrade `docker-ce` so that we can get the latest docker version which allows us to perform image squashing as well as multi-stage builds.
setup_dependencies() { 
  echo -e "INFO:\nSetting up dependencies.\n"

  sudo apt update -y  
  sudo apt install -y -o Dpkg::Options::="--force-confnew" docker-ce  
  docker info
}

# Tweak the daemon configuration so that we can make use of experimental features (like image squashing) as well as have a bigger amount of concurrent downloads and uploads.
update_docker_configuration() {
  echo -e "INFO:\nUpdating docker configuration\n"

  echo '{
    "experimental": true,
    "storage-driver": "overlay2",
    "max-concurrent-downloads": 50,
    "max-concurrent-uploads": 50
  }' | sudo tee /etc/docker/daemon.json
  
  sudo service docker restart
}

main