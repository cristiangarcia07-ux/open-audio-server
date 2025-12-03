# syntax=docker/dockerfile:1
FROM node:14
WORKDIR /app
ENV MUSIC_PATH=/data/music
ENV CACHE_PATH=/data/cache
ENV SYNOMAN_PATH=/data/synoman
ENV THEME_PATH=/data/theme
ENV DSAUDIO_HTML_PATH=/data/html/dsaudio.html
ENV GZIP=true
ENV PORT=5000
ENV HOST=0.0.0.0
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|deb.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until
RUN apt-get update
RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get install -y sox libsox-fmt-all build-essential
RUN git clone https://github.com/openaudioserver/open-audio-server /app
RUN npm install
EXPOSE 5000
CMD [ "node", "server.js" ]
