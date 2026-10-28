#!/bin/bash

PI_USER="larpers"
PI_HOST="10.176.149.157"
PI_DIR="~/assign2/pcr"

scp "${PI_USER}@${PI_HOST}:${PI_DIR}/"{msg.txt,sig.bin,key.pem,pcr.dat} .


echo "################ Verifying original message ################"
#openssl dgst -sha256 -verify public.pem -signature sig.plain message.dat
#tpm2_checkquote -u key.pem -m msg.txt -s sig.bin -g sha256 -f pcr.dat


tpm2_loadexternal -C o -G ecc -u key.pem -c key.ctx
tpm2_verifysignature -Q -c key.ctx -g sha256 -m msg.txt -s sig.bin -t ticket.bin \
&& echo "VERIFY GOOD" || echo "VERIFY BAD"
