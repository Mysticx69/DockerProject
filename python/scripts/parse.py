"""
Parse data
@author: asterna
"""


def parse_data(data_json):
    """Parsing data for dockerproject"""

    json_payload = []

    for item in data_json.get('values'):
        velov = "Velov"
        addr = (item.get('address'))
        commune = item.get('commune')
        capacite_totale = item.get('bike_stands')
        velo_dispo = item.get('available_bikes')

        data = {
            "measurement": velov,
            "Adresse": addr,
            "Commune": commune,
            "Capacite": capacite_totale,
            "Velo dispo": velo_dispo
        }
        json_payload.append(data)

    return json_payload
