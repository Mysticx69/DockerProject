"""
Parse data
@author: tblanchefort
"""
#####Import#####
from datetime import datetime
from influxdb_client import InfluxDBClient, Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS

#####Initialize the Client###########

# You can generate an API token from the "API Tokens Tab" in the UI
token = "5up3r-S3cr3t-auth-t0k3n"
org = "influxdata-org"
bucket = "default"

with InfluxDBClient(url="http://127.0.0.1:8086", token=token, org=org) as client:
    data = ""
    write_api = client.write_api(write_options=SYNCHRONOUS)
    write_api.write(bucket, org, data)