"""
Subscribe to MQTT topic : /data
@author: asterna, tblanchefort
"""

#!/usr/bin/env python3

import paho.mqtt.client as mqtt

#Variables
BROKERIP = "10.150.2.10"
BROKERPORT = "1883"


def on_connect(client, userdata, flags, rc):
    """Coonect to broker and subscribe to /data topic"""
    # This will be called once the client connects
    print(f"Connected with result code {rc}")
    # Subscribe here!
    client.subscribe("/data")


def on_message(client, userdata, msg):
    """print msg when payload received"""
    print(f"Message received [Topic = {msg.topic}]: {msg.payload}")


client = mqtt.Client("mqtt_sub")  # client ID "mqtt-test"
client.on_connect = on_connect
client.on_message = on_message
client.connect('10.150.2.10', 1883)
client.loop_forever()  # Start networking daemon
