"""
Parse data
@author: asterna
"""


def parse_data(data_json):
    """Parsing data for dockerproject"""

    json_payload = []
    print("Nos items : \n")
    for item in data_json.get('values'):

        addr = (item.get('address'))
        commune = item.get('commune')
        capacite_totale = item.get('bike_stands')
        velo_dispo = item.get('available_bikes')

        new_json = (f' {{ \n Addresse : {addr} \n  \
                Commune : {commune} \n \
                capacite : {capacite_totale} \n \
                velo dispo {velo_dispo} \n }}, \n  ')

        print(new_json)
        json_payload.append(data_json)
