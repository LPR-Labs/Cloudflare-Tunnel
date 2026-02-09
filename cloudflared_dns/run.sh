#!/usr/bin/with-contenv bash
set -euo pipefail

CONFIG_PATH="/data/config.yml"
INIT_FLAG="/data/.initialized"

CF_API_TOKEN="$(jq -r '.api_token' /data/options.json)"
DOMAIN="$(jq -r '.domain' /data/options.json)"
SUBDOMAIN="$(jq -r '.subdomain' /data/options.json)"
TUNNEL_NAME="$(jq -r '.tunnel_name' /data/options.json)"

HOSTNAME="${SUBDOMAIN}.${DOMAIN}"

export CLOUDFLARE_API_TOKEN="${CF_API_TOKEN}"

if [ ! -f "${INIT_FLAG}" ]; then
  echo "🔐 First-time Cloudflare Tunnel setup"

  cloudflared tunnel create "${TUNNEL_NAME}"

  TUNNEL_ID="$(
    cloudflared tunnel list --output json \
      | jq -r ".[] | select(.name==\"${TUNNEL_NAME}\") | .id"
  )"

  if [ -z "${TUNNEL_ID}" ]; then
    echo "❌ Failed to determine tunnel ID"
    exit 1
  fi

  cloudflared tunnel route dns "${TUNNEL_ID}" "${HOSTNAME}"

  cat <<EOF > "${CONFIG_PATH}"
tunnel: ${TUNNEL_ID}
credentials-file: /data/${TUNNEL_ID}.json

ingress:
  - hostname: ${HOSTNAME}
    service: http://homeassistant:8123
  - service: http_status:404
EOF

  touch "${INIT_FLAG}"

  echo "✅ Tunnel created at https://${HOSTNAME}"
fi

echo "🚀 Starting Cloudflare Tunnel"
exec cloudflared tunnel --config "${CONFIG_PATH}" run
