#!/bin/bash
apk add --update \
                postfix \
                ;
echo "relayhost = [PHP_SENDMAIL_HOST]:PHP_SENDMAIL_PORT" >> /etc/postfix/main.cf && \
echo "myhostname = PHP_SENDMAIL_HOST" >> /etc/postfix/main.cf && \
echo "inet_interfaces = all" >> /etc/postfix/main.cf && \
echo "recipient_delimiter = +" >> /etc/postfix/main.cf
