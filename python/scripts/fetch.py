"""
Fetch API GrandLyon
@author: asterna
"""
#pylint: disable=W3101
# Imports
import requests


def fetch_api(url):
    """Fetch an API"""

    return requests.get(url).json()
