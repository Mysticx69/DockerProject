"""Main module =>
1. Fetch GrandLyon API
2. Parse DATA for influxDB format and send it
@author: asterna, tblanchefort"""

#Imports
from influxdb_client import InfluxDBClient
from influxdb_client.client.write_api import SYNCHRONOUS
from fetch import fetch_api
from parse import parse_data

TOKEN = "5up3r-S3cr3t-auth-t0k3n"
ORG = "influxdata-org"
BUCKET = "default"
URL = "http://localhost:8086"
DATA = "https://download.data.grandlyon.com/ws/rdata/jcd_jcdecaux.jcdvelov/all.json?maxfeatures=10&start=1"


def main() -> None:
    """Main function"""
    # Fetch API and get JSON response
    ## Parse Data ans send it to influxDB
    data_fetched = fetch_api(DATA)
    print(parse_data(data_fetched))

    with InfluxDBClient(url=URL, token=TOKEN, org=ORG) as client:
        write_api = client.write_api(write_options=SYNCHRONOUS)

        data = parse_data(data_fetched)
        write_api.write(BUCKET, ORG, data)

        query = 'from(bucket: "default") |> range(start: -1h)'
        tables = client.query_api().query(query, org=ORG)
        for table in tables:
            for record in table.records:
                print(record)


if __name__ == "__main__":
    main()
