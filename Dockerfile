FROM ubuntu:17.04

ENV MATTERMOST_ENABLE_SSL=false \
    PLATFORM_PORT_80_TCP_PORT=80

RUN apt-get update && apt-get install -y nginx

RUN rm /etc/nginx/sites-enabled/default

COPY mattermost /etc/nginx/sites-available/
COPY mattermost-ssl /etc/nginx/sites-available/
ADD docker-entry.sh /

RUN chmod +x /docker-entry.sh

# You can see the logs using `docker-compose logs web`.
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Define working directory.
WORKDIR /etc/nginx

ENTRYPOINT /docker-entry.sh

EXPOSE 80 443
