#!/bin/bash

# This is a quick approch for starting many works and setting their concurrency.
# For performance testing.

date
read -p "worker: " w
read -p "concurrency: " c
read -p "press any key to start..." g
date

#s="celeryd-multi start -l debug --logfile=/root/downloads/celery-3.0.12/examples/tutorial/%n.log "
s="celeryd-multi start "

for (( i=1; i<=$w; i=i+1 ))
do
	# Without array method.
	s=$s" w"
	s=$s$i
	s=$s" -c:w"
	s=$s$i
	s=$s" "
	s=$s$c
done

$s
