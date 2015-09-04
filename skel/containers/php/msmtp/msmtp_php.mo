# http://jezhalford.com/2015/01/28/php-mail-function-linux-and-an-external-smtp-server/
# https://wiki.archlinux.org/index.php/Msmtp
defaults
tls     on
tls_trust_file  /etc/ssl/certs/ca-certificates.crt
auth    on
port    587
logfile /tmp/msmtp_php.log

account smtp_service
host    {{PROJECT_SMTP_HOST}}
user    {{PROJECT_SMTP_USER}}
password  {{PROJECT_SMTP_PASSWORD}}

account default : smtp_service
