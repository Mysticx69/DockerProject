"""
Parse data
@author: asterna, tblanchefort
"""

from datetime import datetime


def parse_data(data_json):
    """Parsing data for dockerproject"""

    json_payload = []

    for item in data_json.get('values'):
        velov = "VeloV"
        addr = (item.get('address'))
        commune = item.get('commune')
        capacite_totale = item.get('bike_stands')
        velo_dispo = item.get('available_bikes')

        data = {
            "measurement": velov,
            "tags": {
                "Adresse": addr,
                "Commune": commune,
                "Capacite": capacite_totale
            },
            "time": datetime.now(),
            "fields": {
                "Velo dispo": velo_dispo
            }
        }
        json_payload.append(data)
    return json_payload
