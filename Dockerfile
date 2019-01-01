FROM openjdk:8-jdk-alpine

RUN apk add --update wget dumb-init bash maven && rm -rf /var/cache/apk/*

RUN adduser graphhopper -h /home/graphhopper -D
WORKDIR /home/graphhopper

RUN mkdir -p /data && \
	cd ~graphhopper && \
  wget -q -O graphhopper.tgz https://github.com/graphhopper/graphhopper/archive/0.11.0.tar.gz && \
  tar -xzf graphhopper.tgz && \
  rm -f *.tgz && \
  mv */* . && \
  rm -Rf graphhopper-*

COPY run.sh /home/graphhopper/

EXPOSE 8989
CMD ["/usr/bin/dumb-init", "/bin/bash", "/home/graphhopper/run.sh"]
