FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
      curl \
      git \
      iptables \
      libnetfilter-log1 \
      libpcap-dev \
      python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && rm /usr/sbin/iptables \
    && ln -s /usr/sbin/iptables-legacy /usr/sbin/iptables

RUN pip3 install \
      libnetfilter@git+https://github.com/akerouanton/libnetfilter@40624ac6c93b7cdfba905a905bf7ff1ad3b3034c \
      python-iptables \
    && rm -rf ~/.cache/pip \
    && curl --fail -o /usr/sbin/iptables-trace https://raw.githubusercontent.com/commonism/iptables-trace/master/bin/iptables-trace.py \
    && chmod +x /usr/sbin/iptables-trace

COPY bin/iptables-trace.py /usr/sbin/iptables-trace
ENTRYPOINT ["iptables-trace"]
