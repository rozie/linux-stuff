#!/bin/bash

# create ipset if does not exist
/usr/sbin/ipset list stopforumspam >> /dev/null || /usr/sbin/ipset create stopforumspam hash:ip maxelem 500000

# fetch blocklists
/usr/bin/wget -q https://iplists.firehol.org/files/stopforumspam.ipset -O /tmp/stopforumspam.ipset
/usr/bin/wget -q https://iplists.firehol.org/files/blocklist_net_ua.ipset -O /tmp/blocklist_net_ua.ipset

# remove duplicate entries from lists
/usr/bin/sort -u /tmp/stopforumspam.ipset /tmp/blocklist_net_ua.ipset > /tmp/2add.ipset

# create temporary save file - way faster than adding one by one
/bin/grep -v ^# /tmp/2add.ipset | /usr/bin/awk '{print "add stopforumspam "$1}' > /tmp/2add.save

# remove old entries
/usr/sbin/ipset flush stopforumspam

# insert new entries from save file
/usr/sbin/ipset restore -f /tmp/2add.save
