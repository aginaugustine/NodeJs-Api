FROM alpine:3.15.3

ARG XSZIP
ENV VERSION 0.1
#ENV HTTP_PROXY="http://10.123.0.132:3128"
#ENV HTTPS_PROXY="http://10.123.0.132:3128"
ENV XSCLI=/opt/sap/xs-cli
ENV PATH=$PATH:${XSCLI}/bin

COPY ${XSZIP} /tmp/${XSZIP}

# ps needs to be available to be able to be used in docker.inside, see https://issues.jenkins-ci.org/browse/JENKINS-40101
#RUN  apt-get update
#    sudo apt-get install -y procps && \
#    sudo apt-get install -y unzip 
#    && \
RUN apk add --no-cache unzip && \
    apk add --no-cache procps && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup --gid 1000 -S piper && \
    adduser -S piper --uid 1000 --ingroup piper --shell /bin/bash --home /home/piper && \
    mkdir --parents ${XSCLI} && \
    unzip -d ${XSCLI} /tmp/${XSZIP} && \
    rm -rf /tmp/${XSZIP} && \
    chown --recursive piper:piper ${XSCLI}
    
USER piper
WORKDIR /home/piper
