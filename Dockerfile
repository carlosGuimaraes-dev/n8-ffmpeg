FROM n8nio/n8n:1.116.2
USER root
RUN apk add --no-cache ffmpeg
USER node

#version v1.0
