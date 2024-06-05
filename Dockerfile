FROM ubuntu:24.04

USER root

RUN apt update
RUN apt install -y wget
RUN mkdir -p /opt/caddy
# Download caddy 
RUN wget https://github.com/caddyserver/caddy/releases/download/v2.7.6/caddy_2.7.6_linux_amd64.tar.gz -P /opt/caddy

# Unzip caddy to user bin
RUN tar -xvzf /opt/caddy/caddy_2.7.6_linux_amd64.tar.gz -C /usr/bin

# creating a group for caddy service
RUN groupadd --system caddy

# creating a user to run caddy service
RUN useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

# RUN mkdir -p /etc/caddy

# # copy caddy config
# COPY ./Caddy/Caddyfile /etc/caddy/Caddyfile

# # copy caddy service

# COPY ./Caddy/caddy.service /etc/systemd/system/caddy.service

# copy webapp
RUN mkdir -p /opt/webapp
RUN chmod 755 /opt/webapp
COPY ./webapp/index.html /opt/webapp/index.html

RUN ls -larth /opt/webapp
RUN ls -larth /opt/webapp/
RUN ls -larth /opt

EXPOSE 8080

CMD [ "caddy", "file-server", "--root", "/opt/webapp", "--listen", ":8080" ]