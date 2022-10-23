"""
Parse data
@author: tblanchefort
"""

import json
from datetime import datetime
from influxdb_client import InfluxDBClient
from influxdb_client.client.write_api import SYNCHRONOUS
import paho.mqtt.client as mqtt

######################For MQTT#########################
host_ip = '10.150.2.10'
port = 1883
keepalive = 60
topic = '/data'

#####################For INFLUXDB#######################
token = "5up3r-S3cr3t-auth-t0k3n"
org = "influxdata-org"
bucket = "default"
url = "http://localhost:8086"


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("/data")


def on_message(client, userdata, msg):

    msg_json = json.loads(msg.payload.decode())
    json_payload = []
    velov = "Velov"
    addr = (msg_json.get('Adresse'))
    commune = msg_json.get('Commune')
    capacite_totale = msg_json.get('Capacite')
    velo_dispo = msg_json.get('Velo dispo')

    data = {
        "_measurement": velov,
        "_time": datetime.now(),
        "_fields": {
            "Velo dispo": velo_dispo,
            "Adresse": addr,
            "Commune": commune,
            "test": 1,
            "Capacite": capacite_totale
        }
    }
    json_payload.append(data)

    with InfluxDBClient(url=url, token=token, org=org) as client:
        write_api = client.write_api(write_options=SYNCHRONOUS)

        print(type(data))
        write_api.write(bucket, data)


client = mqtt.Client()
client.connect(host_ip, port, keepalive)
client.on_connect = on_connect
client.on_message = on_message
client.loop_forever()
