$ORIGIN net.cezarmathe.com.
$TTL 1h

; name ttl record class record type record data
; START OF AUTHORITY - MANDATORY
net.cezarmathe.com. IN SOA ns.net.cezarmathe.com. me.net.cezarmathe.com. (2020100705 7200 3600 1209600 3600)

; NAMESERVER - MANDATORY
ns.net.cezarmathe.com. IN NS ns

; RECORDS
tvcxvps.air IN A 165.227.157.142
tvcxserver.dorm IN A 192.168.1.50
tvcxstation.dorm IN A 192.168.1.51
tvcxpi.home IN A 192.168.0.108
tvcxvps.tvcxair IN A 10.125.66.0
tvcxbook.tvcxair IN A 10.125.66.220
tvcxphone.tvcxair IN A 10.125.66.196
tvcxpi.tvcxhome IN A 10.125.42.0
tvcxbook.tvcxhome IN A 10.125.42.110
tvcxphone.tvcxhome IN A 10.125.42.47
tvcxserver.tvcxdorm IN A 10.125.169.0
tvcxstation.tvcxdorm IN A 10.125.169.86
tvcxbook.tvcxdorm IN A 10.125.169.144
tvcxphone.tvcxdorm IN A 10.125.169.84
consul.tvcxvps.tvcxair IN A 10.125.66.0
vault.tvcxvps.tvcxair IN A 10.125.66.0

