"""Main module =>
1. Fetch Fortinet API and return json
2. Extract IP for each FQDN and save it into extract/$FQDN
@author: asterna"""

#Imports

from fetch import fetch_api
from parse import parse_data

URL = "https://download.data.grandlyon.com/ws/rdata/jcd_jcdecaux.jcdvelov/all.json?maxfeatures=5&start=1"


def main() -> None:
    """Main function"""
    # Fetch API and get JSON response
    data_fetched = fetch_api(URL)

    print(parse_data(data_fetched))


if __name__ == "__main__":
    main()
