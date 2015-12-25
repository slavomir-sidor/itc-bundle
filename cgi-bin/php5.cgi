#!/bin/bash
PHPRC=$DOCUMENT_ROOT/../etc/php5
export PHPRC
umask 022
if [ "$REDIRECT_URL" != "" ]; then
  SCRIPT_NAME=$REDIRECT_URL
  export SCRIPT_NAME
fi
SCRIPT_FILENAME=$PATH_TRANSLATED
export SCRIPT_FILENAME
exec /bin/php-cgi
