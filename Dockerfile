FROM openjdk:8-jdk-alpine

RUN apk add --update wget dumb-init git bash maven && rm -rf /var/cache/apk/*

RUN adduser graphhopper -h /home/graphhopper -D
WORKDIR /home/graphhopper

RUN mkdir -p /data && \
	cd ~graphhopper && \
	git clone https://github.com/graphhopper/graphhopper.git . && \
	git checkout 0.11.0 && \
	rm -rf .git

COPY run.sh /home/graphhopper/

EXPOSE 8989
CMD ["/usr/bin/dumb-init", "/bin/bash", "/home/graphhopper/run.sh"]
