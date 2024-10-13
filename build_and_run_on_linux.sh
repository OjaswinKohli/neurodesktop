set -e

if docker ps --all | grep neurodesktop; then
    if docker ps --all | grep neurodeskapp; then
        echo "detected a Neurodeskapp container and ignoring it!"
    else
        bash stop_and_clean.sh
    fi
fi

docker build . -t neurodesktop:latest

docker volume create neurodesk-home
docker run --shm-size=1gb -it --cap-add SYS_ADMIN --security-opt apparmor:unconfined \
    --device=/dev/fuse --name neurodesktop -v ~/neurodesktop-storage:/neurodesktop-storage \
    --mount source=neurodesk-home,target=/home/jovyan \
    --network host \
    -p 8888:8888 \
    --user=root -e NB_UID="$(id -u)" -e NB_GID="$(id -g)" \
    neurodesktop:latest
