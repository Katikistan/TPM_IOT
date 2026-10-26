#!/bin/bash

# change this
PI_USER="larpers"
PI_HOST="larpers.local"
PI_DIR="~/assign2/test/rsa"

# Pull the files from the Pi
scp "${PI_USER}@${PI_HOST}:${PI_DIR}/"{message.dat,sig.rssa,public.pem} .

echo "################ Verifying original message ################"
echo
openssl dgst -sha256 -verify public.pem -signature sig.rssa message.dat
echo

# We tamper with a copy so the original stays intact
cp message.dat message_tampered.dat
printf '%s' 'tamper' >> message_tampered.dat

echo "################ Verifying tampered message (should fail) ################"
echo
openssl dgst -sha256 -verify public.pem -signature sig.rssa message_tampered.dat