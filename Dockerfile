FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,video,utility

RUN mkdir -p /usr/local/bin /patched-lib /workspace
COPY patch.sh docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/patch.sh /usr/local/bin/docker-entrypoint.sh && \
  apt update && apt install -y ffmpeg && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["ffmpeg","-h"]