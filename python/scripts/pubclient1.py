"""
Client 1 publish to MQTT broker
@author: asterna, tblanchefort
"""

#simulator device 1 for mqtt message publishing

import time
import json
import paho.mqtt.client as mqtt
from fetch import fetch_api
from parse import parse_data

MESSAGE = fetch_api(
    url=
    "https://download.data.grandlyon.com/ws/rdata/jcd_jcdecaux.jcdvelov/all.json?maxfeatures=10&start=1"
)
BROKERIP = '10.150.2.10'
PORT = 1883
KEEPALIVE = 60
DATA = parse_data(MESSAGE)
TOPIC = '/data'
client = mqtt.Client()
client.connect(BROKERIP, PORT, KEEPALIVE)
for item in DATA:
    item_dumps = json.dumps(item)
    print(item_dumps)
    time.sleep(1)
    client.publish(TOPIC, item_dumps)

client.loop_forever()  # Start networking daemon
