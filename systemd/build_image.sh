#!/bin/bash
#
# set -x


function build_image() {
  os=${1}
  os_version=${2}
  IMAGE_NAME=org.tecris/${os}_${os_version}-systemd:23.12.02
  echo "=================================================="
  echo "building: ${IMAGE_NAME}"
  echo "=================================================="

  docker buildx build \
    --no-cache \
    --progress=plain \
    -t ${IMAGE_NAME} \
    -f ${os}-${os_version}/Dockerfile \
    ./

  docker buildx build \
    --load \
    -t ${IMAGE_NAME} \
    ./${os}-${os_version}
}

declare -A distrubution_array
distrubution_array[debian]="10,11"
distrubution_array[ubuntu]="18.04,20.04,22.04"

for distribution in "${!distrubution_array[@]}"
do
  os=${distribution}
  os_version_list=${distrubution_array[${distribution}]}
  for os_version in ${distrubution_array[${distribution}]//,/ }
  do
    build_image ${os} ${os_version}
  done

done

