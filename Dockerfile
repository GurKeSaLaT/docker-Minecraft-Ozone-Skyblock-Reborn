# syntax=docker/dockerfile:1

FROM openjdk:17-buster

LABEL version="latest"

RUN apt-get install -y curl unzip && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]

ENV MOTD "Ozone Skyblock Reborn - Server Powered by Docker"
ENV LEVEL world
ENV JVM_OPTS "-Xms6G -Xmx8G"
