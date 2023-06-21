#!/bin/bash

# Appliquer le paramètre hdparm -S 60 à plusieurs disques
/usr/bin/hdparm -S 60 /dev/sda
/usr/bin/hdparm -S 60 /dev/sdb
/usr/bin/hdparm -S 60 /dev/sdc
/usr/bin/hdparm -S 60 /dev/sdd
