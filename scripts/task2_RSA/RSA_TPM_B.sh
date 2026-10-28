#!/bin/bash

# change this
PI_USER="larpers"
PI_HOST="larpers.local"
PI_DIR="~/assign2/test/rsa"

# Pull the files from the Pi
scp "${PI_USER}@${PI_HOST}:${PI_DIR}/"{message.dat,sig.rssa,public.pem} .

echo "################ Loading public key into TPM-B ################"
tpm2_loadexternal -C o -G rsa -u public.pem -c pub.ctx

echo "################ Verifying original message ################"
echo
tpm2_verifysignature -c pub.ctx -g sha256 -m message.dat -s sig.rssa -f rsassa
echo "exit code: $?"
echo

# We tamper with a copy so the original stays intact
cp message.dat message_tampered.dat
printf '%s' 'tamper' >> message_tampered.dat

echo "################ Verifying tampered message (should fail) ################"
echo
tpm2_verifysignature -c pub.ctx -g sha256 -m message_tampered.dat -s sig.rssa -f rsassa
echo "exit code: $?"