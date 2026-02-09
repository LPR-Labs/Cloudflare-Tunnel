ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache jq curl cloudflared

COPY run.sh /etc/services.d/cloudflared/run
RUN chmod +x /etc/services.d/cloudflared/run
