#!/bin/bash

echo
echo "Testing Local bar1"
echo
for i in {1..10}
        do curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ -H "X-ORG: foo"  -H "X-PRODUCT: bar1"; echo "-${i}"
        done
echo
echo
echo "Testing Local bar2"
echo
for i in {1..10}
        do curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ -H "X-ORG: foo"  -H "X-PRODUCT: bar2"; echo "-${i}"
        done
echo
echo
echo "Testing Global"
echo
for i in {1..20}
        do curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ ; echo "-${i}"
        done

        sleep 2
echo
echo
echo
echo "Total Hits: $(curl localhost:9091/metrics | grep ratelimit_solo_io_total_hits)"
echo
echo
