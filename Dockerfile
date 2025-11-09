FROM php:8.5.0RC3-cli-alpine AS builder

RUN apk add python3 py3-rich curl

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN alias composer='php /usr/bin/composer'

COPY . /phpggc

WORKDIR /phpggc

RUN sed -i '1s|.*|#!/usr/bin/env php|' phpggc && chmod +x phpggc && echo "phar.readonly=0" > $PHP_INI_DIR/php.ini

ENTRYPOINT ["/phpggc/phpggc"]
