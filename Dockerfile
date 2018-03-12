FROM python:2.7.14

# Install updates and dependencies
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y -q \
    bzip2 \
    xz-utils \
    curl \
    zip \
    unzip \
    build-essential \
    git \
    ca-certificates \
    libkrb5-dev \
    imagemagick \
    netbase && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN curl -sSJL "https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip" -o /tmp/google-cloud-sdk.zip \
    && unzip -q /tmp/google-cloud-sdk.zip -d /usr/local \
    && rm -f /tmp/google-cloud-sdk.zip \
    && /usr/local/google-cloud-sdk/install.sh \
        --usage-reporting=true \
        --path-update=true \
        --bash-completion=true \
        --rc-path=/root/.bashrc \
        --additional-components app-engine-python app-engine-java beta

env PATH /usr/local/google-cloud-sdk/bin:$PATH

ARG NODE_VERSION=9.7.1
ARG NPM_VERSION=5.7.1
ARG YARN_VERSION=1.5.1
ARG CHROMEDRIVER_VERSION=2.36
ARG PHANTOMJS_VERSION=2.1.1

RUN curl -sSJL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" -o /tmp/node-v$NODE_VERSION-linux-x64.tar.gz \
    && tar -xzf "/tmp/node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && npm install --silent -g npm@"$NPM_VERSION" yarn@"$YARN_VERSION"  \
    && rm -f "/tmp/node-v$NODE_VERSION-linux-x64.tar.gz"

RUN curl -sSJL "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" -o /tmp/chromedriver_linux64.zip \
    && unzip -q /tmp/chromedriver_linux64.zip -d /tmp \
    && chmod +x /tmp/chromedriver \
    && mv -f /tmp/chromedriver /usr/local/share/chromedriver \
    && ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
    && rm -f /tmp/chromedriver_linux64.zip

RUN curl -sSJL "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" -o /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
    && tar -xjf "/tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" -C /usr/local --strip-components=1 \
    && rm -f "/tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2"


RUN pip install virtualenv && pip install -U pytest