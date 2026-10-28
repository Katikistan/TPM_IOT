# IOT Mini Project 2: TPM 

TPM signing with two devices:

- **TPM-A (signer):** a Raspberry Pi with a TPM 2.0 chip. Creates signing key, signs the message `TPM exercise`, and exports only the public key.
- **TPM-B (verifier):** a PC. It pulls the message, signature and public key from TPM-A and verifies the signature with OpenSSL and shows that a tampered message is rejected.

## Repo layout

```
README.md
report.md
scripts/
  rsa/
    RSA_TMB_A.sh      # runs on TPM-A (Pi)
    RSA_TMB_B.sh      # runs on TPM-B (PC)
  ecc/
    ECC_TMB_A.sh      # runs on TPM-A (Pi)
    ECC_TMB_B.sh      # runs on TPM-B (PC)
evidence/
  ...                 
```

## Installing tools

### TPM-A (Pi)

```bash
sudo apt install tpm2-tools openssl
```

We use the Let's Trust TPM board and connect it following the pinout at https://pinout.xyz/pinout/letstrust_tpm, then enable the driver. 


### TPM-B (PC)

```bash
sudo apt install openssl openssh-client 
```

## Start TPM-A

TPM-A is the Pi with the hardware TPM. Nothing needs to be started as a service. Copy over the scripts to the pi, log in over SSH and run the scripts from a working directory


The private key blob (`*.priv`) is encrypted to this TPM and is never copied to TPM-B.

## 3. Start TPM-B

TPM-B is the PC. Edit the variables at the top of the script so they match your setup:

```bash
PI_USER="larpers"
PI_HOST="larpers.local"
PI_DIR="~/assign2/test/ecc" 
```

The script pulls `message.dat`, the signature, and the public key from TPM-A over SSH and then verifies them with OpenSSL.

## 4. Run the RSA experiment

On TPM-A (Pi):

```bash
bash RSA_TPM_A.sh
```

On TPM-B (PC):

```bash
bash RSA_TPM_B.sh
```

Expected output is the same: `Verified OK` for the original message and `Verification failure` for the tampered one. 


## 5. Run the ECC experiment

On TPM-A (Pi):

```bash
bash ECC_TPM_A.sh
```

On TPM-B (PC):

```bash
bash ECC_TPM_B.sh
```

Expected output is the same: `Verified OK` for the original message and `Verification failure` for the tampered one. 

## 6. Run the PCR-bound signing experiment

On TPM-A (Pi):

```bash
bash PCR_TPM_A.sh
```

On TPM-B (PC):

```bash
bash PCR_TPM_B.sh
```
Expected output is: `Verified OK` for the signature produced under the valid PCR state. 
