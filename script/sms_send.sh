#!/bin/sh
# This script send a text sms at the command line by creating
# a sms file in the outgoing queue.
# I use it for testing.

# $1 is the destination phone number
# $2 is the message text
# if you leave $2 or both empty, the script will ask you

#DEST=$1
#TEXT=$2

DEST=$1
shift
TEXT=$@

if [ -z "$DEST" ]; then
  printf "Destination: "
  read DEST
fi

if [ -z "$TEXT" ]; then
  printf "Text: "
  read TEXT
fi

FILE=`mktemp /var/spool/sms/outgoing/send_XXXXXX`

echo "To: $DEST" >> $FILE
echo "" >> $FILE
#echo -n  "$TEXT" >> $FILE
printf "$TEXT" >> $FILE
