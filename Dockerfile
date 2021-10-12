FROM ubuntu
CMD ["bash"]
RUN /bin/sh -c set -ex; apt-get update; apt-get install ansible -y
