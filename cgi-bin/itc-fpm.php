#!/bin/bash

SCRIPT=$(readlink -f $0)
DIR=$(dirname $SCRIPT)

###############################################################################
# -c <path>|<file> Look for php.ini file in this directory                    #
###############################################################################

CONFIG=" -c etc/php-fpm.conf"

###############################################################################
# -e               Generate extended information for debugger/profiler        #
###############################################################################

DEBUG=" -e"

###############################################################################
# -p, --prefix <dir>                                                          #
#                  Specify alternative prefix path to FastCGI process manager #
#                  (default: /usr).                                           #
###############################################################################

PREFIX=" -p ${DIR}/../"

###############################################################################
# -R, --allow-to-run-as-root                                                  #
#                  Allow pool to run as root (disabled by default)            #
###############################################################################

ASROOT=" -R"

CMD="php-fpm ${CONFIG} ${DEBUG} ${PREFIX} ${ASROOT} "

$CMD