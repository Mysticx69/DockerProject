"""
Parse data 
@author: asterna
"""

from fetch import fetch_api


def parse_data(data_json):
    """Parsing data for dockerproject"""

    for item in data_json.get('values'):

        addr = (item.get('address'))
        commune = item.get('commune')
        capacite_totale = item.get('bike_stands')
        velo_dispo = item.get('available_bikes')

        print(addr)
