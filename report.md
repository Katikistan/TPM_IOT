# Assignment 2

## System Setup

TPM-A is hosted on our Raspberry PI.
TPM-B is hosted on one of our laptops.



## TPM-A and TPM-B Architecture



## RSA Signing and Verification Workflow
Signing:
Firstly the parent object is created. Then the child object/ RSA key pair is created - Both are created with RSA encryption.

Next step is to load primary context, rsa public and private keys and export them into rsa.ctx file. The message file is then created.

Then the message is signed using the loaded TPM context.
________ 
Verification:
Firstly the files created at TPM-A are pulled to TPM-B, these are message.dat, sig.rssa, public.pem; So the message, the signature and the public key. 

The original message is the verified by checking the integrity through the public key, signature and message.


## ECC Signing and Verification Workflow
Signing:
Firstly the parent object is created. Then the child object/ ECC key pair is created - Both are created with ECC encryption.

Next step is to load primary context, rsa public and private keys and export them into rsa.ctx file. The message file is then created.

Then the message is signed using the loaded TPM context.
________ 
Verification:
Firstly the files created at TPM-A are pulled to TPM-B, these are message.dat, sig.rssa, public.pem; So the message, the signature and the public key. 

The original message is the verified by checking the integrity through the public key, signature and message.

## PCR-bound key mechanism

## Tampered Key Rejection

## What Can TPM-B Not Conclude?

## Limitation of Experiment