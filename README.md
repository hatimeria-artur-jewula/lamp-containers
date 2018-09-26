#LAMP CONTAINERS

This repository contains docker files prepared to build containers with full LAMP stack. Containers are dived based on PHP version

## Building the container

Go to the desired PHP version folder and run the command

    docker build \
        --force-rm \
        --no-cache \
        -t php{$VERSION}:latest .
        
## Running the container
        
To run container

    docker run \
      --rm \
      --interactive \
      --tty \
    	--name php71 \
      php{$VERSION}:latest
      

## Usage with HAT

Hat is available to use any container image you have installed or is available publicly. To use build image with your project:

1) Publish your build
    - `docker tag php{$VERSION}:latest mydockerhubuser/php{$VERSION}:latest`
    - `docker push mydockerhubuser/php{$VERSION}:latest`
2) use it in HAT
    - `hat li --image-version mydockerhubuser/php{$VERSION}:latest`
