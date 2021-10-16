path="`pwd`"
path=${path%/*}
docker_image=openapitools/openapi-generator-cli:v5.2.0
project="project"
project_yaml=$project.yaml
workdir="/local"

# generate project
docker run --rm -v "${path}:$workdir" $docker_image generate -i $workdir/$project_yaml  -g python-flask -o $workdir/$project

# build project docker image
cd ../$project
docker build -t openapi_server .
docker run -p 8080:8080 openapi_server
