FROM google/debian:wheezy

# install supervisord
RUN apt-get update && apt-get install -y supervisor wget
RUN mkdir -p /var/lock/nsqd /var/run/nsqd /var/log/nsqd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Install NSQ.
RUN \
  mkdir -p /tmp/nsq && \
  wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.5.linux-amd64.go1.4.2.tar.gz -O - | tar -xvz --strip=1 -C /tmp/nsq && \
  mv /tmp/nsq/bin/* /usr/local/bin/ && \
  rm -rf /tmp/nsq

EXPOSE 4150 4151 4160 4161 4170 4171 9005

VOLUME /data

ENTRYPOINT ["/usr/bin/supervisord"]
