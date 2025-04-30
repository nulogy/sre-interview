FROM postgres:17-alpine

RUN apk add --no-cache bash coreutils

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]