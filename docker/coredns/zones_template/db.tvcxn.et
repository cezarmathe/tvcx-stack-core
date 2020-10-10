$ORIGIN {{ zones_template.origin }}
$TTL {{ zones_template.ttl }}

; name ttl record class record type record data
; START OF AUTHORITY - MANDATORY
{{ zones_template.origin }} IN SOA ns.{{ zones_template.origin }} me.{{ zones_template.origin }} ({{ zones_template.serial }} 7200 3600 1209600 3600)

; NAMESERVER - MANDATORY
ns.{{ zones_template.origin }} IN NS ns

; RECORDS
{{#each zones_template.records}}{{ this.name }} IN {{ this.type }} {{ this.payload }}
{{/each}}
