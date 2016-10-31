#!/usr/bin/env bash

set -x -e

S3_URL=s3://is24-infrastructure-public/cloudformation/verified-ssl-certificate
TMP_ZIP=$TMPDIR/lambda_functions.zip

cd lambda

# install python module 'requests'
if [ ! -d "requests" ]; then
    pip install -t $(pwd) '' requests
fi

# if tmp file exists, delete it
if [ -e $TMP_ZIP ]; then rm $TMP_ZIP; fi

# create zip
zip -v -r $TMP_ZIP *.py requests

# upload zip file
aws s3 cp $TMP_ZIP $S3_URL/
