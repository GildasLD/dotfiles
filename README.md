# TODO

```sh
fprintd-enroll

# or create a new signature for all fingers:

fprintd-delete "$USER"
    for finger in {left,right}-{thumb,{index,middle,ring,little}-finger};
    do fprintd-enroll -f "$finger" "$USER";
done

# You can also enroll without an authentication agent : 

fprintd-enroll user

# To verify the newly created fingerprint, use :

fprintd-verify
```
