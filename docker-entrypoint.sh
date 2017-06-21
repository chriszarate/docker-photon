#!/usr/bin/env bash

set -ex

# Install certs if requested.
if [ -d /tmp/certs ]; then
  mkdir -p /usr/share/ca-certificates/local

  for cert in /tmp/certs/*.crt; do
    cp "$cert" "/usr/share/ca-certificates/local/$(basename "$cert")"
    echo "local/$(basename "$cert")" >> /etc/ca-certificates.conf
  done

  update-ca-certificates --fresh
  echo "Added certs from /tmp/certs."
fi

exec "$@"
