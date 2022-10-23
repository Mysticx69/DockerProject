#!/usr/bin/env python3
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    # This will be called once the client connects
    print(f"Connected with result code {rc}")
    # Subscribe here!
    client.subscribe("/data")


def on_message(client, userdata, msg):
    print(f"Message received [Topic = {msg.topic}]: {msg.payload}")


client = mqtt.Client("mqtt_sub")  # client ID "mqtt-test"
client.on_connect = on_connect
client.on_message = on_message
client.connect('10.150.2.10', 1883)
client.loop_forever()  # Start networking daemon