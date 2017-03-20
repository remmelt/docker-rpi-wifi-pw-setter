#! /bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <unzipped raspbian image>"
    exit 1
fi

readonly d="$(dirname ${1})"
readonly f="$(basename ${1})"
readonly path="$(cd "$d" && pwd)"

docker run --rm --privileged --tty --interactive --volume "${path}/${f}:/images/image.img" remmelt/docker-rpi-wifi-pw-setter
