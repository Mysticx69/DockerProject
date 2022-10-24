
"""
Subscribe to MQTT topic : /data
@author: asterna, tblanchefort
"""
#####################For INFLUXDB#######################
token = "5up3r-S3cr3t-auth-t0k3n"
org = "influxdata-org"
bucket = "default"
url = "http://10.150.2.10:8086"

#####Import#####

import paho.mqtt.client as mqtt
import json
from datetime import datetime
from influxdb_client import InfluxDBClient, Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS

#####Initialize the Client###########

# You can generate an API token from the "API Tokens Tab" in the UI
token = "5up3r-S3cr3t-auth-t0k3n"
org = "influxdata-org"
bucket = "default"

#!/usr/bin/env python3



#Variables
BROKERIP = '10.150.2.10'
BROKERPORT = 1883


def on_connect(client, userdata, flags, rc):
    """Coonect to broker and subscribe to /data topic"""
    # This will be called once the client connects
    print(f"Connected with result code {rc}")
    # Subscribe here!
    client.subscribe("/data")

def parser(msg):
    json_payload = []

    data = {
        "measurement": "velov",
        "time": datetime.now(),
        "fields": msg
    }
    json_payload.append(data)
    return json_payload 

def on_message(client, userdata, msg):
    """print msg when payload received"""
    reponse = json.loads(str(msg.payload.decode()))
    reponse = parser(reponse)
    print(f"Message received {reponse}")

    with InfluxDBClient(url=url, token=token, org=org) as client:
        write_api = client.write_api(write_options=SYNCHRONOUS)
        write_api.write(bucket, org, reponse)


client = mqtt.Client("mqtt_sub")  # client ID "mqtt-test"
client.on_connect = on_connect
client.on_message = on_message
client.connect(BROKERIP, BROKERPORT)
client.loop_forever()  # Start networking daemon
