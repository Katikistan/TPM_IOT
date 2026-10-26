#!/bin/bash

PI_USER="larpers"
PI_HOST="larpers.local"
PI_DIR="~/assign2/test/ecc"

scp "${PI_USER}@${PI_HOST}:${PI_DIR}/"{message.dat,sig.plain,public.pem} .


echo "################ Verifying original message ################"
openssl dgst -sha256 -verify public.pem -signature sig.plain message.dat
echo

cp message.dat message_tampered.dat
printf '%s' 'tamper' >> message_tampered.dat

echo "################ Verifying tampered message (should fail) ################"
openssl dgst -sha256 -verify public.pem -signature sig.plain message_tampered.dat