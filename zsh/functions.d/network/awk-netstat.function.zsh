#!/bin/env sh
# Decoding the data from /proc/net/tcp:
# Based on gist https://gist.github.com/staaldraad/4c4c80800ce15b6bef1c1186eaa8da9f

# To read   : https://docs.kernel.org/filesystems/proc.html

awknet() {
	awk 'BEGIN{
    STATES["01"]="TCP_ESTABLISHED"
    STATES["02"]="TCP_SYN_SENT"
    STATES["03"]="TCP_SYN_RECV"
    STATES["04"]="TCP_FIN_WAIT1"
    STATES["05"]="TCP_FIN_WAIT2"
    STATES["06"]="TCP_TIME_WAIT"
    STATES["07"]="TCP_CLOSE"
    STATES["08"]="TCP_CLOSE_WAIT"
    STATES["09"]="TCP_LAST_ACK"
    STATES["0A"]="TCP_LISTEN"
    STATES["0B"]="TCP_CLOSING"
    STATES["0C"]="TCP_NEW_SYN_RECV"
}

function hextodec(str,ret,n,i,k,c){
ret = 0
n = length(str)
for (i = 1; i <= n; i++) {
    c = tolower(substr(str, i, 1))
    k = index("123456789abcdef", c)
    ret = ret * 16 + k
}
return ret
}

function getIP(str,ret){
ret=hextodec(substr(str,index(str,":")-2,2));
for (i=5; i>0; i-=2) {
    ret = ret"."hextodec(substr(str,i,2))
}
ret = ret":"hextodec(substr(str,index(str,":")+1,4))
return ret
}
NR > 1 {
{
    if(NR==2)print "no\tUID\tState\t\t Local\t\t\tRemote";
    LINE_NUMBER=($1);
    LOCAL_IP=getIP($2);
    UID=($8);
    REMOTE_IP=getIP($3);
}
{print LINE_NUMBER"\t" UID"\t" STATES[$4]"\t" LOCAL_IP" - "REMOTE_IP}
}' /proc/net/tcp
}
