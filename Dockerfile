FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    gammu gammu-smsd \
    libmariadb-dev-compat libmariadb-dev \
    mariadb-client \
    curl gettext-base \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY smsdrc.template /app/
COPY entrypoint.sh /app/
COPY on_receive.sh /app/

RUN chmod +x /app/entrypoint.sh /app/on_receive.sh

ENTRYPOINT ["/app/entrypoint.sh"]