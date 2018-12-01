#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Print all executed commands to terminal.
# set -x

if [[ -f build/bin/phpdesktop ]]; then
    rm build/bin/phpdesktop
fi

if [[ -f debug.log ]]; then
    rm debug.log
fi

count=`ls -1 build/bin/phpdesktop/*.log 2>/dev/null | wc -l`
if [[ ${count} != 0 ]]; then
    rm build/bin/*.log
fi

make -R -f Makefile "$@"

rc=$?;
if [[ ${rc} = 0 ]]; then
    echo "OK phpdesktop was built";
    ./build/bin/phpdesktop
    rm -r blob_storage/
    rm -r GPUCache/
else
    echo "ERROR";
    exit ${rc};
fi