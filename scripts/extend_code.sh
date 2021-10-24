path="`pwd`"
path=${path%/*}
project="project"

ex_package_origin=$path/scripts/extend_code/ex_package
ex_package_target=$path/$project/openapi_server/
cp -R $ex_package_origin $ex_package_target
python extend_code/do_some_magic.py $path/$project/openapi_server
rc=$?
cd $path/scripts

exit $rc
