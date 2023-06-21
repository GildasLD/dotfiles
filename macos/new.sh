#!/bin/bash

# Let's "secure" even the script for you :)
sudo -v

function ok() {
	echo -e "[OK] "$1
}

function bot() {
	echo -e "\[._.]/ - "$1
}

function running() {
	echo -en " → "$1": "
}

bot "This script will disable some agents and daemons. What would you like to do?"
read -r -p "(E)xecute, (R)estore, or (Q)uit  [default=E] " response
response=${response:-E}
if [[ $response =~ (e|E) ]]; then
	# Execute disable
	CMD_TO_RUN "unload"
elif [[ $response =~ (r|R) ]]; then
	# Restore backup
	CMD_TO_RUN "load"
elif [[ $response =~ (q|Q) ]]; then
	echo "Quitting.." >&2
	exit 0
else
	echo "Wrong input, follow directions, idiot. But I'll just quit anyways" >&2
	exit 0
fi

#---------------------------------------------------------------------
# Agents - Comment to not remove
#---------------------------------------------------------------------

# AGENTS=('com.apple.security.keychainsyncingoveridsproxy')

# Dictation
AGENTS=('com.apple.DictationIM')

# Disable Calendar  - Possibly safe to keep disable might still function.
# AGENTS+=('com.apple.CalendarAgent')

# Telephony.... this may cause 100% cpu issues if SIP is enabled - FaceTime/Calls
# AGENTS+=('com.apple.telephonyutilities.callservicesd')

#AGENTS+=('com.apple.assistant') #Keychain
#AGENTS+=('com.apple.bird') #Part of iCloud

# airplay
AGENTS+=('com.apple.AirPlayUIAgent')

# airport basestation client - you don't need it if you don't run an airport base station.
AGENTS+=('com.apple.AirPortBaseStationAgent')
#sudo launchctl disable system/airportd #if you don't use wi-fi

# Speech & Voice - Comment these out if you use discord (or a chromium based browser?), it may break.
# sudo rm -rf /System/Library/Speech/Voices/
AGENTS+=('com.apple.VoiceOver')
AGENTS+=('com.apple.speech.voiceinstallerd')
AGENTS+=('com.apple.speech.synthesisserver')
AGENTS+=('com.apple.speech.recognitionserver')
AGENTS+=('com.apple.speech.feedbackservicesserver')
AGENTS+=('com.apple.speech.speechsynthesisd')
AGENTS+=('com.apple.speech.speechdatainstallerd')

# Photos.app - image recognition
AGENTS+=('com.apple.photoanalysisd')

# background uploading of photos.
AGENTS+=('com.apple.cloudphotosd')

# GameCenter
AGENTS+=('com.apple.gamed')

# Find My Friends daemon
AGENTS+=('com.apple.icloud.fmfd')
AGENTS+=('com.apple.icloud.findmydeviced.findmydevice-user-agent')

# Siri
AGENTS+=('com.apple.assistant_service')

# AOSPushRelay = BAD for your privacy.
AGENTS+=('com.apple.AOSPushRelay')

# Seedusage daemon - used by feedback assistant.
AGENTS+=('com.apple.appleseed.seedusaged')

# parental controls (see the prefs page, it's shit)
AGENTS+=('com.apple.parentalcontrols.check')
AGENTS+=('com.apple.familycontrols.useragent')

# CloudKit. not needed for syncing.
AGENTS+=('com.apple.cloudd')
AGENTS+=('com.apple.assistantd')

# location suggestions for siri, spotlight + messages suggestions, safari lookup
AGENTS+=('com.apple.parsecd')
AGENTS+=('com.apple.identityservicesd')

# iChat / Messages.app
AGENTS+=('com.apple.soagent')

# iCloud Notifications
AGENTS+=('com.apple.librariand')
AGENTS+=('com.apple.icloud.AOSNotificationAgent')
AGENTS+=('com.apple.icloud.AOSNotificationLoginAgent')

# iTunes home sharing and other junk.
AGENTS+=('com.apple.rtcreportingd')
sudo launchctl disable system/rtcreportingd

# Maps.app
AGENTS+=('com.apple.Maps.mapspushd')
AGENTS+=('com.apple.Maps.pushdaemon')

# Safari sending out browsing history ;)
AGENTS+=('com.apple.SafariCloudHistoryPushAgent')

# AGENTS+=('com.apple.security.cloudkeychainproxy3')
# AGENTS+=('com.apple.security.idskeychainsyncingproxy')
# AGENTS+=('com.apple.security.keychain-circle-notification')
# AGENTS+=('com.apple.iCloudUserNotifications')

# Family Notifications
AGENTS+=('com.apple.familycircled')
AGENTS+=('com.apple.familynotificationd')
AGENTS+=('com.apple.cloudfamilyrestrictionsd-mac')
# AGENTS+=('com.apple.syncdefaultsd')

AGENTS+=('com.apple.personad')
AGENTS+=('com.apple.passd')

# Address Book
AGENTS+=('com.apple.AddressBook.SourceSync')
AGENTS+=('com.apple.AddressBook.abd')

AGENTS+=('com.apple.CommCenter-osx')

# Disable Twitter
# AGENTS+=('twitterd')

# Disable Facetime
# AGENTS+=('com.apple.imagent')
# AGENTS+=('com.apple.iChat.Theater')

# Disable Pasteboard
# AGENTS+=('com.apple.pboard')
# AGENTS+=('com.apple.pbs')

# Cloud Pairing
# AGENTS+=('com.apple.cloudpaird')

#Related to call history (iCloud)
AGENTS+=('com.apple.CallHistorySyncHelper')
AGENTS+=('com.apple.CallHistoryPluginHelper')

# IMFoundation.framework
# AGENTS+=('com.apple.IMLoggingAgent')

# Location Spying
AGENTS+=('com.apple.geodMachServiceBridge')

# If you dont' use Sharing
# AGENTS+=('com.apple.sharingd')

# Disable QuickLookHelper
#AGENTS+=('com.apple.quicklook.32bit')
#AGENTS+=('com.apple.quicklook.config')
#AGENTS+=('com.apple.quicklook')
#AGENTS+=('com.apple.quicklook.ui.helper')

# Disable SWAP
# AGENTS+=('com.apple.dynamic_pager')
# sudo rm -f /private/var/vm/swapfile*

# Disable AppStoreHelpers & Check for macOS Update notif
# AGENT+=('com.apple.storeagent')
# AGENT+=('com.apple.store_helper')
# AGENT+=('com.apple.maspushagent')
# AGENT+=('com.apple.softwareupdate_notify_agent')

# Disable Sync
AGENTS+=('com.apple.screensharing.MessagesAgent')

# Disable Sync
AGENTS+=('com.apple.RemoteDesktop')
AGENTS+=('com.apple.safaridavclient')         #Sending bookmarks to iCloud
AGENTS+=('com.apple.SafariNotificationAgent') #Notifications in Safari
AGENTS+=('com.apple.bookstoreagent')
AGENTS+=('com.apple.UserNotificationCenterAgent')
AGENTS+=('com.apple.UserNotificationCenterAgent-LoginWindow')
AGENTS+=('com.apple.ZoomWindow')
AGENTS+=('com.apple.helpd')

# iTunes Helper
AGENTS+=('com.apple.iTunesHelper.launcher')

# Java
#if [ -e "/System/Library/LaunchAgents/com.apple.java.updateSharing" ]; then
# AGENTS+=('com.apple.java.updateSharing')
#fi
AGENTS+=('com.apple.java.InstallOnDemand')

# Screensharing
AGENTS+=('com.apple.screensharing.agent')

# Sync
AGENTS+=('com.apple.security.cloudkeychainproxy')
AGENTS+=('com.apple.syncservices.SyncServer')
AGENTS+=('com.apple.syncservices.uihandler')

# Disable ReportCrash
sudo defaults write com.apple.CrashReporter DialogType none
AGENTS+=('com.apple.ReportCrash.Self')
AGENTS+=('com.apple.ReportCrash')
AGENTS+=('com.apple.ReportPanic')
AGENTS+=('com.apple.ReportGPURestart')
AGENTS+=('com.apple.SocialPushAgent')

#---------------------------------------------------------------------
# Daemons - Comment to not remove
#---------------------------------------------------------------------
# Disable unwanted network services - comment this if you use network shares
DAEMONS=('com.apple.netbiosd')

# Airplay Daemon
# DAEMONS+=('com.apple.AirPlayXPCHelper')

# Notifications
# DAEMONS+=('com.apple.AOSNotificationOSX')

# Diagnostics - Who tf wants to submit diagnostics in 2019
DAEMONS+=('com.apple.SubmitDiagInfo')

# Crash Reporter
DAEMONS+=('com.apple.CrashReporterSupportHelper')

# Location
DAEMONS+=('com.apple.locationd')
DAEMONS+=('com.apple.locationmenu')

# Parental Controls
DAEMONS+=('com.apple.familycontrols')

# Find My Mac
DAEMONS+=('com.apple.findmymac')

# iCloud
DAEMONS+=('com.apple.icloud.findmydeviced')
DAEMONS+=('com.apple.iCloudStats')
DAEMONS+=('com.apple.mbicloudsetupd')

# Auto Sync Time/Zone
# DAEMONS+=('com.apple.preferences.timezone.admintool')
# DAEMONS+=('com.apple.preferences.timezone.auto')

# Pairing Remote Devices
# DAEMONS+=('com.apple.remotepairtool')

# ReportCrash analyzes crashing processes and saves a crash report to disk.
DAEMONS+=('com.apple.remotecrash.root')

# Remote Debugging Mobile Devices
DAEMONS+=('com.apple.rpmuxd')

# Sends encrypted CoreStorage key recovery information to Apple.
# DAEMONS+=('com.apple.security.FDERecoveryAgent')

# more find my mac stuff
DAEMONS+=('com.apple.findmymacmessenger')

# Sending out diagnostics & usage
DAEMONS+=('com.apple.awdd')

# Screensharing
DAEMONS+=('com.apple.screensharing')

# DAEMONS+=('com.apple.appleseed.fbahelperd')

# ApplePushService daemon for Apple Push Notification service.
# DAEMONS+=('com.apple.apsd')

# DAEMONS+=('com.apple.FileSyncAgent.sshd')

# Disable helping install client Device Enrollment profiles.
# DAEMONS+=('com.apple.ManagedClient.cloudconfigurationd') #Related to manage current macOS user iCloud
# DAEMONS+=('com.apple.ManagedClient.enroll') #Related to manage current macOS user
# DAEMONS+=('com.apple.ManagedClient.startup') #Related to manage current macOS user
# DAEMONS+=('com.apple.ManagedClient') #Related to manage current macOS user

# Schedule something?
# DAEMONS+=('com.apple.laterscheduler')

# #Apple Wide Area Connectivity Service - for devices using Back to My Mac.
DAEMONS+=('com.apple.awacsd')

# Perform privileged operations required by certain EAPOLClientConfiguration.h APIs
# DAEMONS+=('com.apple.eapolcfg_auth')

# Used by mds to scan and index files as a volume is mounted or a file changes.
# DAEMONS+=('com.apple.spindump')
# DAEMONS+=('com.apple.tailspind')

# Also part of Reporting Crashes
DAEMONS+=('com.apple.ReportCrash.Root')

bot "Agents"
for agent in "${AGENTS[@]}"; do
	running "trigger agent/${agent}"
	{
		sudo launchctl $CMD_TO_RUN -w /System/Library/LaunchAgents/${agent}.plist
		launchctl $CMD_TO_RUN -w /System/Library/LaunchAgents/${agent}.plist
	} &> /dev/null
	if [[ $response =~ (e|E) ]]; then
		sudo mv /System/Library/LaunchAgents/${agent}.plist /System/Library/LaunchAgents/${agent}.plist.bkp
	elif [[ $response =~ (r|R) ]]; then
		sudo mv /System/Library/LaunchAgents/${agent}.plist.bkp /System/Library/LaunchAgents/${agent}.plist
	fi
	ok
done

bot "Daemons"
for daemon in "${DAEMONS[@]}"; do
	running "trigger daemons/${daemon}"
	{
		sudo launchctl $CMD_TO_RUN -w /System/Library/LaunchDaemons/${daemon}.plist
		ok
		launchctl $CMD_TO_RUN -w /System/Library/LaunchDaemons/${daemon}.plist
	} &> /dev/null
	if [[ $response =~ (e|E) ]]; then
		sudo mv /System/Library/LaunchDaemons/${daemon}.plist /System/Library/LaunchDaemons/${daemon}.plist.bkp
	elif [[ $response =~ (r|R) ]]; then
		sudo mv /System/Library/LaunchDaemons/${daemon}.plist.bkp /System/Library/LaunchDaemons/${daemon}.plist
	fi
	ok
done

bot "Backups saved on /System/Library/LaunchAgents/\*.plist.bkp"

#---------------------------------------------------------------------
# End of Daemon and Agent Killer
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# So long unnecessary things
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Remove Spotlight
#---------------------------------------------------------------------
sudo mdutil -a -i off
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
killall SystemUIServer
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

#---------------------------------------------------------------------
# Remove Notification Center
#---------------------------------------------------------------------
# sudo chmod 600 /System/Library/CoreServices/NotificationCenter.app/Contents/MacOS/NotificationCenter;killall NotificationCenter; killall Dock
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

#---------------------------------------------------------------------
# Minimize Dock
#---------------------------------------------------------------------
# sudo defaults write com.apple.dock pinning -string start
# sudo defaults write com.apple.dock tilesize -int 20

#---------------------------------------------------------------------
# Remove Dashboard
#---------------------------------------------------------------------
sudo defaults write com.apple.dashboard mcx-disabled -boolean YES

#---------------------------------------------------------------------
# Disable MissionControl
#---------------------------------------------------------------------
sudo defaults write com.apple.dock mcx-expose-disabled -bool TRUE

#---------------------------------------------------------------------
# Disable Hibernation
#---------------------------------------------------------------------
# sudo pmset -a hibernatemode 0
# sudo rm -rf /var/run/sleepimage
# sudo rm -rf /private/var/run/sleepimage

#---------------------------------------------------------------------
# Disable Sudden Motion Sensor
#---------------------------------------------------------------------
# sudo pmset -a sms 0

#---------------------------------------------------------------------
# Disable Wake on Power
#---------------------------------------------------------------------
# sudo pmset -a womp 0

# Push the StandbyDelay(write RAM to SSD) at end of day.
# sudo pmset -a standbydelay 0

#---------------------------------------------------------------------
# Disable AirDrop
#---------------------------------------------------------------------
sudo defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES

#---------------------------------------------------------------------
# Disable Local TimeMachine Snapshots
#---------------------------------------------------------------------
hash tmutil &> /dev/null && sudo tmutil disable local

#---------------------------------------------------------------------
# Set NoAtime
#---------------------------------------------------------------------
set noAtime
cat << EOF | sudo tee /Library/LaunchDaemons/com.nullvision.noatime.plist > /dev/null
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.nullvision.noatime</string>
        <key>ProgramArguments</key>
        <array>
            <string>mount</string>
            <string>-vuwo</string>
            <string>noatime</string>
            <string>/</string>
        </array>
        <key>RunAtLoad</key>
        <true />
    </dict>
</plist>
EOF

chown root:wheel /Library/LaunchDaemons/com.nullvision.noatime.plist
chmod 644 /Library/LaunchDaemons/com.nullvision.noatime.plist
sudo launchctl load -w /Library/LaunchDaemons/com.nullvision.noatime.plist

#---------------------------------------------------------------------
# Remove Printers
#---------------------------------------------------------------------
#sudo rm -rf /Library/Printers/

#---------------------------------------------------------------------
# Disable Thumbnails in Safari Quick Access
#---------------------------------------------------------------------
sudo defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#---------------------------------------------------------------------
# Delete Automator
#---------------------------------------------------------------------
# sudo rm -rf /Applications/Automator.app/
# sudo rm -rf /System/Library/Automator/
# sudo rm -rf /System/Library/CoreServices/Automator\ Launcher.app
# sudo rm -rf /System/Library/CoreServices/System\ Image\ Utility.app/Contents/Library/Automator/
# sudo rm -rf /System/Library/Frameworks/Automator.framework/

#---------------------------------------------------------------------
# Uninstall system apps
#---------------------------------------------------------------------
#sudo rm -rf /Applications/Automator.app
#sudo rm -rf /Applications/iBooks.app
sudo rm -rf /Applications/Reminders.app
sudo rm -rf /Applications/Stickies.app
sudo rm -rf /Applications/TextEdit.app
#sudo rm -rf /Applications/Notes.app
sudo rm -rf /Applications/Photo\ Booth.app
sudo rm -rf /Applications/DVD\ Player.app
#sudo rm -rf /Applications/Mission\ Control.app
sudo rm -rf /Applications/Dashboard.app
#sudo rm -rf /Applications/Dictionary.app
#sudo rm -rf /Applications/Game\ Center.app
#sudo rm -rf /Applications/Calculator.app
#sudo rm -rf /Applications/Calendar.app
#sudo rm -rf /Applications/Chess.app
#sudo rm -rf /System/Library/Screen\ Savers
#sudo rm -rf /System/Library/Frameworks/Automator.framework
#sudo rm -rf /System/Library/CoreServices/System\ Image\ Utility.app/Contents/Library/Automator
#sudo rm -rf /System/Library/CoreServices/Automator\ Runner.app
#sudo rm -rf /System/Library/CoreServices/Automator\ Launcher.app
#sudo rm -rf /Applications/Mail.app
#sudo rm -rf /Applications/Messages.app
#sudo rm -rf /Applications/FaceTime.app
sudo rm -rf /Applications/Maps.app

# Start performance tuner

#echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
#defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#echo "Enable subpixel font rendering on non-Apple LCDs"
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Enable the 2D Dock"
defaults write com.apple.dock no-glass -bool true

# Automatically hide and show the Dock
# defaults write com.apple.dock autohide -bool true

echo "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool false

echo "Enable iTunes track notifications in the Dock"
defaults write com.apple.dock itunes-notifications -bool false

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# echo "Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Auto"

echo "Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

# Disable window animations and Get Info animations in Finder
#defaults write com.apple.finder DisableAllAnimations -bool true

#echo "Show all filename extensions in Finder"
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#echo "Use current directory as default search scope in Finder"
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#echo "Show Path bar in Finder"
#defaults write com.apple.finder ShowPathbar -bool true

#echo "Show Status bar in Finder"
#defaults write com.apple.finder ShowStatusBar -bool true

#echo "Expand save panel by default"
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

#echo "Expand print panel by default"
#defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

#echo "Disable the “Are you sure you want to open this application?” dialog"
#defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

#echo "Enable highlight hover effect for the grid view of a stack (Dock)"
#defaults write com.apple.dock mouse-over-hilte-stack -bool true

#echo "Enable spring loading for all Dock items"
#defaults write enable-spring-load-actions-on-all-items -bool true

#echo "Show indicator lights for open applications in the Dock"
#defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
#defaults write com.apple.dock launchanim -bool false

echo "Display ASCII control characters using caret notation in standard text views"
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0.1

#echo "Set a shorter Delay until key repeat"
#defaults write NSGlobalDomain InitialKeyRepeat -int 5

#echo "Disable auto-correct"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#echo "Disable opening and closing window animations"
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

#echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

#echo "Display full POSIX path as Finder window title"
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#echo "Show item info below desktop icons"
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

#echo "Enable snap-to-grid for desktop icons"
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true

#echo "Require password immediately after sleep or screen saver begins"
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0

#echo "Enable tap to click (Trackpad)"
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

#echo "Map bottom right Trackpad corner to right-click"
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

echo "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.Safari.plist UniversalSearchEnabled -bool NO
defaults write com.apple.Safari.plist SuppressSearchSuggestions -bool YES
defaults write com.apple.Safari.plist WebsiteSpecificSearchEnabled -bool NO

echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#echo "Only use UTF-8 in Terminal.app"
#defaults write com.apple.terminal StringEncodings -array 4

echo "Disable the Ping sidebar in iTunes"
defaults write com.apple.iTunes disablePingSidebar -bool true

echo "Disable all the other Ping stuff in iTunes"
defaults write com.apple.iTunes disablePing -bool true

#echo "Make ⌘ + F focus the search input in iTunes"
#defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

#echo "Disable send and reply animations in Mail.app"
#defaults write com.apple.Mail DisableReplyAnimations -bool true
#defaults write com.apple.Mail DisableSendAnimations -bool true

echo "Disable Resume system-wide"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

echo "Disable the “reopen windows when logging back in” option"
# This works, although the checkbox will still appear to be checked.
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

#echo "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
#defaults write com.apple.dashboard devmode -bool true

#echo "Reset Launchpad"
#[ -e ~/Library/Application\ Support/Dock/*.db ] && rm ~/Library/Application\ Support/Dock/*.db

#echo "Show the ~/Library folder"
#chflags nohidden ~/Library

#echo "Remove Dropbox’s green checkmark icons in Finder"
#file=/Applications/Dropbox.app/Contents/Resources/check.icns
#[ -e "$file" ] && mv -f "$file" "$file.bak"
#unset file

#echo "Kill affected applications"
#for app in Safari Finder Dock SystemUIServer; do
#	killall "$app" > /dev/null 2>&1;
#done

# Disabling Maverick's Unicast ARP Cache Validation Script (thanks, MMV!)
bash <(curl -Ls http://git.io/6YzLCw)

# Disable Bonjour Script (thanks MMV!)
bash <(curl -Ls http://git.io/q9j5Zw)

exit 0
