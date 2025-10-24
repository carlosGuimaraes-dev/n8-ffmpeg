FROM n8nio/n8n:1.116.2
USER root
# Adiciona o curl junto com o ffmpeg
RUN apk add --no-cache ffmpeg curl
USER node

#version v1.2
