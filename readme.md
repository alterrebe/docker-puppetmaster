# Puppetmaster

Creates a Puppet Master running with Apache/Passenger and Librarian-Puppet

Build

* `docker build -t puppetmaster .`
* `docker run puppetmaster`

Note: It is easiest to run the container with the hostname of `puppet`.  For
example, `docker run -h puppet.yourcompany.com -d puppetmaster`

Ports
* 8140 (puppet)
