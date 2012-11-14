#!/bin/bash

# For calculating the float number result.

end="`cat /tmp/end.txt`"
start="`cat /tmp/start.txt`"

r=$(echo $end $start | awk '{printf("%.4f", ($1-$2)*10000/10000)}')

echo $r
