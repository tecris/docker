#!/bin/bash
#
# set -x


IMAGE_TAG=$(date +"%y.%m.%d")

function build_image() {
  os=${1}
  os_version=${2}
  IMAGE_NAME=org.tecris/${os}_${os_version}-systemd:${IMAGE_TAG}
  echo "=================================================="
  echo "building: ${IMAGE_NAME}"
  echo "=================================================="

  docker buildx build \
    --no-cache \
    --progress=plain \
    --load \
    -t ${IMAGE_NAME} \
    -f ${os}-${os_version}/Dockerfile \
    ./

}

declare -A distrubution_array
distrubution_array[debian]="11,12"
distrubution_array[ubuntu]="20.04,22.04,24.04"

for distribution in "${!distrubution_array[@]}"
do
  os=${distribution}
  os_version_list=${distrubution_array[${distribution}]}
  for os_version in ${distrubution_array[${distribution}]//,/ }
  do
    build_image ${os} ${os_version}
  done

done

