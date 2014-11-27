#!/bin/sh

HOSTNAME=`hostname`

if [ -f /var/lib/puppet/ssl/certs/$HOSTNAME.pem ]; then
	echo "* Correct SSL certificates are already generated"
else
	echo "* Remove old certificates and run Puppet Master to regenerate them"
	rm -rf /var/lib/puppet/ssl/*
	puppet master --no-daemonize --verbose &
	PM_PID=$!
	sleep 10
	echo "* Terminating Puppet Master to run it again with Passenger"
	kill $PM_PID
	echo "* Fix Apache vhost config"
	sed -i "s,SSLCertificateFile[[:space:]]\+/var/.*$,SSLCertificateFile\t/var/lib/puppet/ssl/certs/$HOSTNAME.pem,;s,SSLCertificateKeyFile[[:space:]]\+/var/.*$,SSLCertificateKeyFile\t/var/lib/puppet/ssl/private_keys/$HOSTNAME.pem," /etc/apache2/sites-available/puppetmaster.conf
fi

exec /usr/sbin/apache2ctl -D FOREGROUND
