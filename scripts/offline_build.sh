version=${1:-dev}

docker save -o IMAGES_$version \
openapi_server:$version \
exportapp:$version \
export-client:$version \
ansible_ping_test:$version \
ubuntu:20.04 \
redis:latest \
nginx:latest \
debian:9-slim \
python:3-alpine \
pandoc/latex:latest \
openapitools/openapi-generator-cli:v5.2.0 \
afourmy/flask-gentelella:latest
