#!/bin/bash

# Create teh primary key
tpm2_createprimary -C o -g sha256 -G ecc -c primary.ctx

# reset PCR state in PCR 16
tpm2_pcrreset 16

# set a predetermined value into PCR 16
tpm2_pcrextend 16:sha256=$(echo -n "expected-state" | sha256sum | cut -d' ' -f1)

# read the PCR 16 into a prc.dat file
tpm2_pcrread -o pcr.dat "sha256:16"

# make the policy digest (hash)
tpm2_startauthsession -S session.dat
tpm2_policypcr -S session.dat -l "sha256:16" -f pcr.dat -L policy.dat
tpm2_flushcontext session.dat

# Create the signing key that is bound the policy
tpm2_create -C primary.ctx -G ecc256:ecdsa-sha256 -L policy.dat -u key.pub -r key.priv

# load the context from the TMP
tpm2_load -C primary.ctx -u key.pub -r key.priv -c key.ctx
tpm2_readpublic -c key.ctx -f pem -o key.pem 

# Make message and sign it with the correct PCR state
echo "TMP exercise" > msg.txt
tpm2_startauthsession --policy-session -S session.dat
tpm2_policypcr -S session.dat -l "sha256:16"
tpm2_sign -c key.ctx -g sha256 -o sig.bin -p session:session.dat msg.txt
tpm2_flushcontext session.dat

# Change PCR state and try again to sign, which should fail
echo "-------THIS SHOULD FAIL---------"
tpm2_pcrextend 16:sha256=$(echo -n "tampered" | sha256sum | cut -d' ' -f1)
tpm2_startauthsession --policy-session -S session.dat
tpm2_policypcr -S session.dat -l "sha256:16" 
tpm2_sign -c key.ctx -g sha256 -o bad.bin -p session:session.dat msg.txt
tpm2_flushcontext session.dat
