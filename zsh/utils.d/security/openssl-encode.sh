#!/bin/bash

# Memo

LC_ALL=C head -c 42 /dev/urandom | base64 | tee $PWD/key.key &&
	dd if=/dev/random of=$PWD/fichier_clair.txt bs=1M count=512 &&
	openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
		-pass file:$PWD/key.key \
		-in $PWD/fichier_clair.txt -out $PWD/fichier_chiffre.enc

openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 100000 \
	-pass file:$PWD/key.key \
	-in $PWD/fichier_chiffre.enc -out $PWD/fichier_dechiffre.txt

cryptsetup luksFormat --cipher serpent-xts-plain64 --sector-size 4096 --key-size 512 \
	--pbkdf argon2id --iter-time 5000 --pbkdf-memory 3145728 --pbkdf-parallel 16 /dev/sdXX

# echo -n "key" | openssl dgst -sha3-256 -binary | base64
