#!/bin/bash

# change this
PI_USER="larpers"
PI_HOST="larpers.local"
PI_DIR="~/assign2/test/ecc"

# pull the files from the pi
scp "${PI_USER}@${PI_HOST}:${PI_DIR}/"{message.dat,sig.plain,public.pem} .


echo "################ Loading public key into TPM-B ################"
tpm2_loadexternal -C o -G ecc -u public.pem -c pub.ctx

echo "################ Verifying original message ################"
tpm2_verifysignature -c pub.ctx -g sha256 -m message.dat -s sig.plain -f ecdsa
echo "exit code: $?"
echo

cp message.dat message_tampered.dat
printf '%s' 'tamper' >> message_tampered.dat

echo "################ Verifying tampered message (should fail) ################"
tpm2_verifysignature -c pub.ctx -g sha256 -m message_tampered.dat -s sig.plain -f ecdsa
echo "exit code: $?"