#!/bin/sh
envsubst < /app/smsdrc.template > /etc/gammu-smsdrc

exec gammu-smsd -c /etc/gammu-smsdrc
