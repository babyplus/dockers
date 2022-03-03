image="${1:-openapi_server}"
data_path="${2:-/tmp}"
bash generate_code.sh $image &&\
bash extend_code.sh &&\
bash service.sh $image $data_path
