FROM alpine:3.18

RUN apk update && \
    apk add --no-cache curl jq bash

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]