#!/bin/bash

echo " \$BASH_SUBSHELL outside subshell       = $BASH_SUBSHELL"           # 0

  ( echo " \$BASH_SUBSHELL inside subshell        = $BASH_SUBSHELL" )     # 1
  ( ( echo " \$BASH_SUBSHELL inside nested subshell = $BASH_SUBSHELL" ) ) # 2
# ^ ^                           *** nested ***                        ^ ^

echo

echo " \$SHLVL outside subshell = $SHLVL"       # 3
( echo " \$SHLVL inside subshell  = $SHLVL" )   # 3 (No change!)

# Processes 
(watch -p -t -n 1 "ps -eaxo pid,ppid,pcpu,tt,tid,class,rtprio,ni,pri,psr,pcpu,stat,fname,tmout,f,wchan,wchan:14,comm,euid,ruid,tty,tpgid,sess,pgrp,user | awk -F' ' '"'{print "SKITCServer;"$HOSTNAME";"$IP";"$2";"$1";"$3";"$4";"$5";"$6";"$7";"$8;$9;$10;$11;$12;$13;$14;$15;$16;$17;$18;$19;$20;$21;$22;$23;$24;$25}'"'")

# Disks

# Mysql

# Apache
