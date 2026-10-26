#! /bin/bash

# Create parent object
tpm2_createprimary -C e -G rsa -c primary.ctx

# Create child object/RSA key pair
tpm2_create -G rsa -u rsa.pub -r rsa.priv -C primary.ctx

# Loads Primary Context and rsa public and private keys and exports it into rsa.ctx file.
tpm2_load -C primary.ctx -u rsa.pub -r rsa.priv -c rsa.ctx

# Creates message file
echo "TPM exercise" > message.dat

# Signs the message file using the loaded TPM context.
tpm2_sign -c rsa.ctx -g sha256 -s rsassa -f plain -o sig.rssa message.dat

tpm2_readpublic -c rsa.ctx -o child.pem -f pem
