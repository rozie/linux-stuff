# linux-stuff
Various linux related stuff and scripts

## ipset_manager.sh

Description
---------
Script to update IPs from blocklist in ipset.
It can be run from cron. Example:

```
0 */2 * * * /root/ipset_manager.sh 2>&1 > /tmp/ipset.log
```

Requirements
---------

- Requires ipset installed.
- Requires iptables rules using this ipset. They can be created by:

```
iptables -I INPUT 1 -m set --match-set stopforumspam src -j DROP
iptables -I FORWARD 1 -m set --match-set stopforumspam src -j DROP
```
