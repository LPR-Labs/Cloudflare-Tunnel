ARG BUILD_FROM
FROM $BUILD_FROM

LABEL \
  io.hass.type="addon" \
  io.hass.version="1.0.0"

RUN apk add --no-cache \
  bash \
  jq \
  curl \
  cloudflared

COPY run.sh /etc/services.d/cloudflared/run
RUN chmod +x /etc/services.d/cloudflared/run
