#! /bin/bash

# Create parent object
tpm2_createprimary -C e -G ecc -c primary.ctx

# Create child object/RSA key pair
tpm2_create -G ecc -u ecc.pub -r ecc.priv -C primary.ctx

# Loads Primary Context and rsa public and private keys and exports it into rsa.ctx file.
tpm2_load -C primary.ctx -u ecc.pub -r ecc.priv -c ecc.ctx

# Creates message file
echo "TPM exercise" > message.dat

# Signs the message file using the loaded TPM context.
tpm2_sign -c ecc.ctx -g sha256 -s ecdsa -f der -o sig.der message.dat

tpm2_readpublic -c ecc.ctx -o public.pem -f pem
