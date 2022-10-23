"""
Client 1 publish to MQTT broker
@author: asterna, tblanchefort
"""

#simulator device 1 for mqtt message publishing

import time
import paho.mqtt.client as mqtt

BROKERIP = '172.17.0.1'
PORT = 1883
KEEPALIVE = 60
TOPIC = 'API'
client = mqtt.Client()
client.connect(BROKERIP, PORT, KEEPALIVE)
i = 0
while True:
    time.sleep(5)
    i += 1
    MESSAGE = str(i)
    if i <= 10:
        client.publish(TOPIC, MESSAGE)
    else:
        break
client.disconnect()
