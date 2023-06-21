# Macos TIPS

## About .DS_Store files

### Disable .DS_Store files on network drives :

```sh
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
```

### Disable .DS_Store files on USB drives :

```sh
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

### Disable the creation of .DS_Store files in the current directory and its subdirectories

```sh
defaults write com.apple.desktopservices DSDontWriteLocalDSFiles -bool true
```

## Enable / disable System Integrity Protection

1. Restart your computer in Recovery mode.
2. Launch Terminal from the Utilities menu.
3. Run the command `csrutil enable || csrutil disable`.
4. Restart your computer.

## BREWS

- marmaduke-chromium
- marmaduke-chromium-nosync

```sh
brew tap mtslzr/marmaduke-chromium ; brew update ; brew install marmaduke-chromium ;
brew uninstall marmaduke-chromium; brew untap mtslzr/marmaduke-chromium ;
```

---

## Mac Terminal WiFi Commands

1. Turn off wifi on your macbook from the Mac OSX terminal command line :

```sh
shnetworksetup -setairportpower en0 off
```

2. Turn on wifi on your macbook from the Mac OSX terminal command line :

```sh
networksetup -setairportpower en0 on
```

3. List available wifi networks from the Mac OSX terminal command line :

```sh
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan
```

4. Join a wifi network from the Mac OSX terminal command line :

```sh
networksetup -setairportnetwork en0 WIFI_SSID_I_WANT_TO_JOIN WIFI_PASSWORD
```

5. Find your network interface name :

```sh
networksetup -listallhardwareports
```

### Ipv6

networksetup -getinfo Wi-Fi
networksetup -setv6off Wi-Fi
networksetup -setv6automatic Wi-Fi

###

scutil --set HostName OOOOOO
scutil --set ComputerName OOOOOO
scutil --set LocalHostName OOOOOO

## Colors

```sh
mkdir -p ~/.grc
vim ~/.grc/ifconfig
```

```
\binet6\s*([a-f0-9:]+)\b  magenta
\binet\s*([0-9.]+)\b      green
```

```sh
grc ifconfig
```

---
