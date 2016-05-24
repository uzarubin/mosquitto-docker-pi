FROM resin/rpi-raspbian:jessie

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install apt-utils
RUN apt-get install build-essential g++
RUN apt-get install openssl
RUN apt-get install cmake
RUN apt-get install libssl-dev
RUN apt-get install libc-ares-dev
RUN apt-get install uuid-dev
RUN apt-get install daemon
RUN apt-get install make
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
