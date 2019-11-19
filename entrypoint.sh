#!/bin/sh -l

echo "====================="
echo "= Running OPA Tests ="
echo "====================="

export
helm plugin list

if [ "$INPUT_HELM" == "true" ]; then
    echo helm conftest -p $INPUT_POLICY -o $INPUT_OUTPUT --namespace $INPUT_NAMESPACE $INPUT_PATH
    helm conftest -p $INPUT_POLICY -o $INPUT_OUTPUT --namespace $INPUT_NAMESPACE $INPUT_PATH
else
    conftest test -p $INPUT_POLICY -o $INPUT_OUTPUT --namespace $INPUT_NAMESPACE $INPUT_PATH
fi
