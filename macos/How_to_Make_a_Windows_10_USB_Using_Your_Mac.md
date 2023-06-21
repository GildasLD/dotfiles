## How to Make a Windows 10 USB Using MacOS

```sh
diskutil list

diskutil eraseDisk MS-DOS "WIN10" GPT /dev/disk2 ||
diskutil eraseDisk MS-DOS "WIN10" MBR /dev/disk2

hdiutil mount ~/Downloads/Win10_1903_V1_English_x64.iso

rsync -vha --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_EN-US_DV9/* /Volumes/WIN10

brew install wimlib (install.wim – is too large to copy over to a FAT-32 formatted USB drive)

mkdir /Volumes/WIN10/sources

wimlib-imagex split /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/WIN10/sources/install.swm 3800
```
