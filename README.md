# mosquitto-docker-pi
Mosquitto under docker on the pi

## Building Docker file
  
  > docker build -t="pi/mosquitto:V1.0" -f ./Dockerfile .
  
  
## Running Docker Image
  > docker run -p 1883:1883 -p 9001:9001 -d pi/mosquitto:V1.0 mosquitto -c /mqtt/config/mosquitto.conf
  
  
  
