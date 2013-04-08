#!/bin/bash
#
# Startup script for services
#
# chkconfig: 2345 85 15
#
# processname: myprocessd
# pidfile: /var/run/myprocessd.pid

# Source function library.
. /etc/rc.d/init.d/functions

RETVAL=0
process_name="myprocess"
MYPROCESSD=/usr/bin/myprocessd
PID_FILE=/var/run/myprocessd.pid

start()
{
        echo -n $"Starting $process_name: "
        $MYPROCESSD --pidfile $PID_FILE && success || failure
        RETVAL=$?
        echo
        return $RETVAL
}

stop()
{
        echo -n $"Stopping $process_name: "
        killproc -p $PID_FILE -d 10 $MYPROCESSD
        RETVAL=$?
        echo
}

reload()
{
        echo -n $"Reloading $process_name: "
        if [ -n "`pidfileofproc $MYPROCESSD`" ] ; then
            killproc $MYPROCESSD -HUP
        else
            # Fails if the pid file does not exist BEFORE the reload
            failure $"Reloading $process_name"
        fi
        sleep 1
        if [ ! -e $PID_FILE ] ; then
            # Fails if the pid file does not exist AFTER the reload
            failure $"Reloading $process_name"
        fi
        RETVAL=$?
        echo
}

case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;
        restart)
                stop
                start
                ;;
        reload)
                reload
                ;;
        status)
                status -p $PID_FILE $MYPROCESSD
                RETVAL=$?
                ;;
        *)
                echo $"Usage: $0 {start|stop|restart|reload|status}"
                RETVAL=1
esac
exit $RETVAL
