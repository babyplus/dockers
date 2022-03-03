FROM ubuntu:20.04
CMD ["bash"]
RUN /bin/sh -c set -ex; apt-get update; apt-get install ansible sshpass -y
