# Assignment 2

## System Setup

TPM-A is hosted on our Raspberry PI.
TPM-B is hosted on one of our laptops.


TPM-A is hosted on our Raspberry PI.
TPM-B is hosted on one of our laptops.


**Connecting the tpm using the pinout:**
Looking at the diagram found at https://pinout.xyz/pinout/letstrust_tpmt we orientate the Pi with the GPIO on the right and the HDMI ports on the left. On the TPM we can see the the 3v3 power, we use place that on pin 17 on the pi, thereby aligning all the pins and installing the tpm according to the pinout diagram. 

![Picture of TPM connected on our pi|500](evidence/task_1/PXL_20261023_133921712.MP.jpg)

Afterwards we manually enable the driver inside the config.txt located in
/boot/firmware/config.txt and below the [all] section we add:
```
dtoverlay=tpm-slb9670
```

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
A PCR-bound key is a TPM-protected key that can only be used if the system booted in the expected way. During boot, each stage is measured into the TPM's PCRs, which record the boot chain. The key's authorization policy requires these PCRs to match specific expected values, so the key is only usable on an untampered system.

## Tampered Key Rejection
Evidence that the tampered key is rejected can be found in the evidence folder /evidence/task2_RSA/tpm_b.png.
We added to the script that TPM-B should also attempt to verify a tampered message, this message can be found in /scripts/task2_RSA/message_tampered.dat. 

The same goes for the ECC implementation, it is exactly the same setup.

## What Can TPM-B Not Conclude?
TPM-B can't conclude wheter any of the context, signature or keys were genereated from another TPM. It can only verify that the message hasn't been tampered with using the signature and public key it got from TPM-A. Basically TPM-B can conclude whether a message has been tampered with. It cannot conclude on whether the source (TPM-A) is actually a TPM.

## Limitation of Experiment