# FreeCAD Docker Image

An up-to-date docker image with the required environment to build and run FreeCAD. Based on David Daish's original [FreeCAD docker image](https://gitlab.com/daviddaish/freecad_docker_env).

The FreeCAD source code and build are ***not*** included in the docker image. You must download or clone the repo. The project files will be attached to the docker container when you run the container. This allows the built code to have continuity across different docker containers, reducing the time for a build to occur, and allowing you to use your own editor/IDE outside of the container.

## Image Setup

### Pull image

Coming Soon

<!-- ```sh
docker pull registry.gitlab.com/daviddaish/freecad_docker_env:latest
``` -->

### Run image

>**For mac users:**
>
>In order to use the GUI, you must install [XQuartz](https://www.xquartz.org/).
>
>Then, open XQuartz with `open -a XQuartz`, and ensure "Allow connections from
>within network clients" is ticked, under the "Security" tab. This process was
>taken from this [blogpost](https://sourabhbajaj.com/blog/2017/02/07/gui-applications-docker-mac/).

Allow local xhost access, so you can use the GUI.

```sh
xhost +local:
```

You must specify the following enviroment variables before running the docker image:

Env Variable | Default | Description | Location in container
--- | --- | --- | ---
FREECAD_SOURCE | ~/Code/FreeCAD | The root directory of the FreeCAD source code, basically where you have cloned the FreeCAD GitHub repo | `/mnt/source`
FREECAD_BUILD | ~/Code/FreeCAD_build | Output directory for the FreeCAD build | `/mnt/build`
MISC_FILES | ~/Code/FreeCAD/other | A custom directory containing any other files you'd like to use, such as `.fcstd` files, for testing | `/mnt/files`

You can directly set the values in your environment like this:

```sh
FREECAD_SOURCE=~/code/freecad_source
FREECAD_BUILD=~/code/freecad_build
MISC_FILES=~/
```

Or update the `init.sh` script with your custom values and then run `. ./init.sh`.

After setting up the environment, run the docker image.

```sh
docker run -it --rm \
-v $FREECAD_SOURCE:/mnt/source \
-v $FREECAD_BUILD:/mnt/build \
-v $MISC_FILES:/mnt/files \
-e "DISPLAY" -e "QT_X11_NO_MITSHM=1" -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
bombillazo/freecad_docker:latest
```

<!-- 
```sh
docker run -it --rm \
-v $FREECAD_SOURCE:/mnt/source \
-v $FREECAD_BUILD:/mnt/build \
-v $MISC_FILES:/mnt/files \
-e "DISPLAY" -e "QT_X11_NO_MITSHM=1" -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
registry.gitlab.com/daviddaish/freecad_docker_env:latest
``` -->

## FreeCAD Setup

Once your image is running, connect to the image via your terminal or from the Docker terminal. Once inside the image you can run commands to build and run FreeCAD.

### Build FreeCAD

```sh
/root/build_script.sh
```

### Run FreeCAD

```sh
/mnt/build/bin/FreeCAD
```

## Building the image

Build times for the docker image will depend on your machine's specification and network.

```sh
docker build -t bombillazo/freecad_docker:latest .
```

Note that, because of the size of the dependencies, docker may throw a `no
space left on device` error part way through the build. To reduce the
likelyhood of this, ensure you have around 25GB of space on your storage, and
running `docker system prune`.

<!-- ### Pushing the docker image

Prior to pushing, the image must be able to reliabily build the most recent
tags of the FreeCAD source code: `master`, `0.19_pre`, and `0.18.4`.

```sh
docker login registry.gitlab.com
docker push registry.gitlab.com/daviddaish/freecad_docker_env:updates
``` -->
