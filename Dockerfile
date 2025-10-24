FROM n8nio/n8n:1.116.2
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends ffmpeg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER node
# (Opcional) Sanity-check no boot:
# CMD ["bash","-lc","which ffmpeg && ffmpeg -version && n8n start"]
