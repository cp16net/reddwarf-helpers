#!/usr/bin/env bash

NOVA_HOME=/src
GLANCE_HOME=/glance

NL=`echo -ne '\015'`

function screen_it {
    screen -S nova -X screen -t $1
    screen -S nova -p $1 -X stuff "$2$NL"
}

CONFFILE="--flagfile=/vagrant/nova-vag.conf"

screen -d -m -S nova -t nova
sleep 1

screen_it glance-reg "sudo $GLANCE_HOME/bin/glance-registry /vagrant/glance-reg.conf --debug"
screen_it glance-api "sudo $GLANCE_HOME/bin/glance-api /vagrant/glance-api.conf --debug"

screen_it platform "sudo $NOVA_HOME/bin/reddwarf-api $CONFFILE"
screen_it api "sudo $NOVA_HOME/bin/nova-api $CONFFILE"
screen_it compute "sudo $NOVA_HOME/bin/nova-compute $CONFFILE"
screen_it network "sudo $NOVA_HOME/bin/nova-network $CONFFILE"
screen_it scheduler "sudo $NOVA_HOME/bin/nova-scheduler $CONFFILE"
screen_it volume "sudo $NOVA_HOME/bin/nova-volume $CONFFILE"
screen_it test ". $NOVA_HOME/novarc$1"
screen -S nova -x
