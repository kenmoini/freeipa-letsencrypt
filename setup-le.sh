#!/usr/bin/bash
set -o nounset -o errexit

WORKDIR="/opt/freeipa-letsencrypt"

curl -O https://dl.eff.org/certbot-auto && \
  mv certbot-auto /sbin/certbot && \
  chmod +x /sbin/certbot

ipa-cacert-manage install "$WORKDIR/ca/DSTRootCAX3.pem" -n DSTRootCAX3 -t C,,
ipa-certupdate -v

ipa-cacert-manage install "$WORKDIR/ca/LetsEncryptAuthorityX3.pem" -n letsencryptx3 -t C,,
ipa-certupdate -v

"$(dirname "$0")/renew-le.sh" "--first-time"
