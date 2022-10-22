"""
Parse data 
@author: asterna
"""

from fetch import fetch_api


def parse_data(data_json):
    """Parsing data for dockerproject"""
    print("Nos item : \n")
    for item in data_json.get('values'):

        addr = (item.get('address'))
        commune = item.get('commune')
        capacite_totale = item.get('bike_stands')
        velo_dispo = item.get('available_bikes')

        new_json = (
            f' {{ \n Addresse : {addr} \n Commune : {commune} \n capacite : {capacite_totale} \n velo dispo {velo_dispo}  \n }},  '
        )
        print(new_json)
