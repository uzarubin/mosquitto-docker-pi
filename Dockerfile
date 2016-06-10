FROM armv7/armhf-ubuntu:wily

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y openssl \
		       make \
		       build-essential \
		       g++ \
		       cmake \
                       libssl-dev \
                       libc-ares-dev \
                       uuid-dev \
                       daemon 
COPY libwebsockets /libwebsockets
RUN cd /libwebsockets && cmake .
RUN cd /libwebsockets && make install
RUN ldconfig
COPY mosquitto-1.4.8 /mosquitto-1.4.8
RUN cd /mosquitto-1.4.8 && make && make install
RUN mkdir -p /mqtt/config
RUN cd /mosquitto-1.4.8 && cp mosquitto.conf /mqtt/config/mosquitto.conf
RUN adduser --system --disabled-password --disabled-login mosquitto
EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
