FROM node:13.10-alpine

LABEL maintainer="Nasir Hussain (https://nasirhussain.tech)"

# Get Hugo Version
ARG HUGO_VERSION=0.67.1

# Downloading & Installing Hugo & Firebase
RUN set -x && \
    apk add --update --upgrade --no-cache wget ca-certificates && \
    update-ca-certificates && \
    cd /tmp && \

    # Download Hugo
    wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -O hugo.tar.gz && \
    tar xzf hugo.tar.gz && \
    mv hugo /usr/bin/hugo && \
    rm -r * && \
    apk del --purge wget && \

# Start the building & deploying now
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]