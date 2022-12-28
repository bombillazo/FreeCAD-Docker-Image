#!/bin/bash

BOLD='\033[1m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

#  Update these if to match your project paths and structure!
FREECAD_SOURCE=~/Code/FreeCAD
FREECAD_BUILD=~/Code/FreeCAD_build
MISC_FILES=~/Code/FreeCAD/other

echo "${BOLD}Setting FreeCAD Docker image environment variables...${NC}\n"

echo "FREECAD_SOURCE=$FREECAD_SOURCE"
echo "FREECAD_BUILD=$FREECAD_BUILD"
echo "MISC_FILES=$MISC_FILES"N

echo "\n${GREEN}Setup complete!${NC}\nVerify these paths exists before running docker image container:\n"
echo "${CYAN}docker run -it --rm \\
-v \$FREECAD_SOURCE:/mnt/source \\
-v \$FREECAD_BUILD:/mnt/build \\
-v \$MISC_FILES:/mnt/files \\
-e "DISPLAY" -e "QT_X11_NO_MITSHM=1" -v /tmp/.X11-unix:/tmp/.X11-unix:ro \\
bombillazo/freecad_docker:latest${NC}"