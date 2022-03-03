path="`pwd`"
path=${path%/*}
docker_image=openapitools/openapi-generator-cli:v5.2.0
target_image=${1:-openapi_server}
project="project"
project_yaml=$project.yaml
workdir="/local"

# clean old
rm -rf $path/$project

# generate project
docker run --rm -v "${path}:$workdir" $docker_image generate -i $workdir/$project_yaml  -g python-flask -o $workdir/$project

# build project docker image
cd $path/$project
echo >> Dockerfile
echo >> Dockerfile
echo 'RUN apk add --no-cache bash' >> Dockerfile
echo >> Dockerfile
echo 'RUN apk add --no-cache docker' >> Dockerfile
echo >> Dockerfile
sed 's/Flask == 1.1.2/Flask==1.1.4/g' requirements.txt -i
echo >> requirements.txt
echo markupsafe==2.0.1 >> requirements.txt
echo >> requirements.txt
echo 'waitress >= 2.0.0' >> requirements.txt
cat $path/scripts/customization/__main__.py > __main__.py
cat $path/scripts/customization/__main__.py > openapi_server/__main__.py
docker build -t $target_image .

#go back to the scripts` dir
cd $path/scripts
