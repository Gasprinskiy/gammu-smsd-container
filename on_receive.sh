#!/bin/bash

SENDER_NUMBER="$SMS_1_NUMBER"

curl -X POST "$MESSAGE_HANDLER_ENDPOINT" \
    -H "Content-Type: application/json" \
    -d "{\"sender_number\":\"$SENDER_NUMBER\"}" \
    --silent --output /dev/null

exit 0
