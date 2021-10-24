path="`pwd`"
path=${path%/*}
docker_image=openapitools/openapi-generator-cli:v5.2.0
project="project"
project_yaml=$project.yaml
workdir="/local"

# clear old
rm -rf $path/$project

# generate project
docker run --rm -v "${path}:$workdir" $docker_image generate -i $workdir/$project_yaml  -g python-flask -o $workdir/$project

# build project docker image
cd $path/$project
docker build -t openapi_server .

#go back to the scripts` dir
cd $path/scripts
