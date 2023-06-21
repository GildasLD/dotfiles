#!/bin/bash

# I have managed to map out some undesirable daemons and agents. Most of these
# can be disabled without too much consequence.

#TODO Add new Daemons

## Daemons
# com.apple.analyticsd                        - Anonymized application analytics daemon
# com.apple.appleseed.fbahelperd              - Feedback Assistant Helper Daemon
# com.apple.awacsd                            - Apple Wide Area Connectivity Service Daemon
# com.apple.backupd                           - Apple TimeMachine service
# com.apple.backupd-helper                    - Apple TimeMachine service
# com.apple.biokitaggdd                       - Apple Biometrics
# com.apple.biometrickitd X                   - Apple Biometrics (for fingerprint)
# com.apple.dprivacyd                         - Data gatherer called Differential Privacy that forwards anonymized information to Apple
# com.apple.duetknowledged                    - Some kind of analytics or siri thing?
# com.apple.findmymac                         - Apple Find My Device service
# com.apple.findmymacmessenger                - Apple Find My Device service
# com.apple.GameController.gamecontrollerd    - Gamepad daemon service
# com.apple.icloud.findmydeviced              - Apple Find My Device service
# com.apple.ifdreader                         - Service to read smart cards
# com.apple.locationd                         - Apple location services
# com.apple.ManagedClient.cloudconfigurationd - Mobile Device Management
# com.apple.ManagedClient.enroll              - Mobile Device Management
# com.apple.ManagedClient                     - Mobile Device Management
# com.apple.ManagedClient.startup             - Mobile Device Management
# com.apple.mdmclient.daemon                  - Mobile Device Management Client daemon
# com.apple.mdmclient.daemon.runatboot        - Mobile Device Management Client daemon
# com.apple.nfcd                              - Near Field Communication Daemon
# com.apple.remotemanagementd                 - Mobile Device Management
# com.apple.remotepairtool                    - Daemon for pairing ir remotes
# com.apple.ReportCrash.Root                  - Send Crash Reports to Apple
# com.apple.SubmitDiagInfo                    - Diagnostic Reports submission dialog

## Agents
# com.apple.AirPortBaseStationAgent                      - Auto manages AirPort network devices
# com.apple.AOSPushRelay                                 - Push notification relay service
# com.apple.ap.adservicesd                               - Guessing public access point ad feeds agent?
# com.apple.appleseed.seedusaged                         - Feedback Assistant agent
# com.apple.appleseed.seedusaged.postinstall             - I think this is the "Get to know macOS" popup
# com.apple.assistantd                                   - Siri assistance daemon
# com.apple.assistant_service                            - Siri assistance service
# com.apple.bluetooth.PacketLogger                       - Points ot a missing Apple internal tool
# com.apple.cloudd                                       - iCloud
# com.apple.cloudpaird                                   - iCloud pairing
# com.apple.cloudphotosd                                 - iCloud photos synching
# com.apple.DictationIM                                  - Audio dictation for iMessage
# com.apple.findmymacmessenger                           - Apple Find My Device service
# com.apple.followupd                                    - Apple Find My Friends service
# com.apple.FollowUpUI                                   - Apple Find My Friends service
# com.apple.gamed                                        - Apple Game Center daemon
# com.apple.homed                                        - Apple HomePod integration agent
# com.apple.icloud.findmydeviced.findmydevice-user-agent - Apple Find My Device service
# com.apple.icloud.fmfd                                  - Apple Find My Friends service
# com.apple.java.InstallOnDemand                         - Java Installation agent
# com.apple.knowledge-agent                              - Siri local knowledge database
# com.apple.lateragent                                   - "Remind Me Later" update nag
# com.apple.ManagedClientAgent.agent                     - Mobile Device Management
# com.apple.ManagedClientAgent.enrollagent               - Mobile Device Management
# com.apple.Maps.pushdaemon                              - Map data fetching and pushing
# com.apple.mdmclient.agent                              - Mobile Device Management Client agent
# com.apple.mediaremoteagent                             - Apple ir receiver agent
# com.apple.parentalcontrols.check                       - Parental controls enforcement check
# com.apple.parsecd                                      - Spotlight Suggestions agent
# com.apple.parsec-fbf                                   - Spotlight Suggestions agent
# com.apple.passd                                        - The Apple Pay and Wallet daemon
# com.apple.photoanalysisd                               - iCloud photo optimization service
# com.apple.ReportCrash                                  - Apple Remote Crash Reporter service
# com.apple.security.keychain-circle-notification        - iCloud Keychain sync
# com.apple.sharingd                                     - Social media sharing daemon
# com.apple.Siri.agent                                   - Siri
# com.apple.siriknowledged                               - Siri
# com.apple.SocialPushAgent                              - Social media updates agent
# com.apple.softwareupdate_notify_agent                  - Apple Software Updates notifications
# com.apple.SoftwareUpdateNotificationManager            - Apple Software Updates notifications
# com.apple.suggestd                                     - Siri suggestions
# com.apple.ReportCrash                                  - Send Crash Reports to Apple

# Colors :
NC="\033[0m"
RED="\033[0;31m"
GREEN="\033[0;32m"

# Stderr and exit with an error
die() {
	clear
	echo -e "${RED}$* ${NC}\n" >&2
	exit 2
}

if [[ $EUID != 0 ]]; then
	die "You must be root !"
fi

#TODO Check that names have not changed
# Daemons to disable
daemons=('com.apple.CrashReporterSupportHelper' 'com.apple.DumpPanic' 'com.apple.DumpPanic.Accessory' 'com.apple.GameController.gamecontrollerd' 'com.apple.ManagedClient' 'com.apple.ManagedClient.cloudconfigurationd' 'com.apple.ManagedClient.enroll' 'com.apple.ManagedClient.startup' 'com.apple.ReportCrash.Root' 'com.apple.SubmitDiagInfo' 'com.apple.analyticsd' 'com.apple.appleseed.fbahelperd' 'com.apple.awacsd' 'com.apple.backupd' 'com.apple.backupd-helper' 'com.apple.biokitaggdd' 'com.apple.biomed' 'com.apple.dprivacyd' 'com.apple.findmy.findmybeaconingd' 'com.apple.findmymac' 'com.apple.findmymacmessenger' 'com.apple.icloud.findmydeviced' 'com.apple.icloud.searchpartyd' 'com.apple.ifdreader' 'com.apple.locationd' 'com.apple.mdmclient.daemon' 'com.apple.mdmclient.daemon.runatboot' 'com.apple.nfcd' 'com.apple.osanalytics.osanalyticshelper' 'com.apple.remotemanagementd' 'com.apple.remotepairtool' 'com.apple.symptomsd' 'com.apple.sysdiagnose' 'com.apple.sysdiagnose.darwinos' 'com.apple.systemstats.analysis' 'com.apple.systemstats.daily')

#TODO Check that names have not changed
# Agents to disable
agents=('com.apple.AirPortBaseStationAgent' 'com.apple.AOSPushRelay' 'com.apple.ap.adservicesd' 'com.apple.appleseed.seedusaged' 'com.apple.appleseed.seedusaged.postinstall' 'com.apple.assistantd' 'com.apple.assistant_service' 'com.apple.bluetooth.PacketLogger' 'com.apple.cloudphotosd' 'com.apple.DictationIM' 'com.apple.findmymacmessenger' 'com.apple.followupd' 'com.apple.FollowUpUI' 'com.apple.gamed' 'com.apple.homed' 'com.apple.icloud.findmydeviced.findmydevice-user-agent' 'com.apple.icloud.fmfd' 'com.apple.java.InstallOnDemand' 'com.apple.knowledge-agent' 'com.apple.lateragent' 'com.apple.ManagedClientAgent.agent' 'com.apple.ManagedClientAgent.enrollagent' 'com.apple.mdmclient.agent' 'com.apple.mediaremoteagent' 'com.apple.parentalcontrols.check' 'com.apple.parsecd' 'com.apple.parsec-fbf' 'com.apple.passd' 'com.apple.photoanalysisd' 'com.apple.ReportCrash' 'com.apple.security.keychain-circle-notification' 'com.apple.sharingd' 'com.apple.Siri.agent' 'com.apple.siriknowledged' 'com.apple.SocialPushAgent' 'com.apple.softwareupdate_notify_agent' 'com.apple.SoftwareUpdateNotificationManager' 'com.apple.suggestd' 'com.apple.ReportCrash')

# Process array of daemons (leigon)
for daemon in "${daemons[@]}"; do
	{
		/usr/libexec/PlistBuddy -c "Add Disabled bool true" /System/Library/LaunchDaemons/${daemon}.plist
		launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist
	} &> /dev/null
	# If the disabled flag is set, print success message
	daemon_flag=$(/usr/libexec/PlistBuddy -c "Print Disabled" /System/Library/LaunchDaemons/${daemon}.plist 2> /dev/null)
	if [[ ${daemon_flag} == 'true' ]]; then
		printf "[${GREEN}SUCCESS${NC}] Disabled ${daemon}\n"
	else
		printf "[${RED}ERROR${NC}] Failed to disable ${daemon}\n"
	fi
done

# For each daemon in the above arrays, add a Disabled key set to true to each
# daemon plist. Next, unload each daemon. As an unnecessary added measure,
# specify a (deprecated) permanent write to the launchctl cache.
#
# The script also reads back the Disabled key's value from the specified daemon
# plist.
#
#TODO: Get rid of super lazy duplicate code block.

# Process array of agents (FBI?)
for agent in "${agents[@]}"; do
	{
		/usr/libexec/PlistBuddy -c "Add Disabled bool true" /System/Library/LaunchAgents/${agent}.plist
		launchctl unload -w /System/Library/LaunchAgents/${agent}.plist
	} &> /dev/null
	# If the disabled flag is set, print success message
	agent_flag=$(/usr/libexec/PlistBuddy -c "Print Disabled" /System/Library/LaunchAgents/${agent}.plist 2> /dev/null)
	if [[ ${agent_flag} == 'true' ]]; then
		printf "[${GREEN}SUCCESS${NC}] Disabled ${agent}\n"
	else
		printf "[${RED}ERROR${NC}] Failed to disable ${agent}\n"
	fi
done
