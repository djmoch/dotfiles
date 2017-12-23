#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from datetime import datetime
import math
from os import environ
import sys
import forecastio
import requests

def generate_forecast():
    error = False

    try:
        # I keep my api key for forecast.io in a separate text file so I don't accidentally publish it anywhere.
        with open('forecastio_api.txt', 'r') as apifile:
            api_key = apifile.read()
            api_key = api_key.strip()

        # Resolving location from IP is always going to be a best guess, but it's better than hardcoding location data
        latitude, longitude = requests.get('https://ipinfo.io').json()['loc'].split(',')

        # Now we're ready to actually get the weather
        forecast = forecastio.load_forecast(api_key, latitude, longitude)

        current_temp = forecast.currently()
        day = forecast.daily()

        temp = str(current_temp.temperature) + " F"
        high = str(int(math.ceil(day.data[0].temperatureMax)))
        low = str(int(math.ceil(day.data[0].temperatureMin)))

        with open('current_forecast.txt', 'w') as outfile:
            outfile.write(temp + ", " + str(current_temp.summary) + ", " + high +"/"+low + " F")
    except requests.packages.urllib3.exceptions.NewConnectionError:
        error = True
        if DEBUG:
            sys.stdout.writelines(datetime.now().strftime("%m/%d/%Y %I:%M:%S:") + " Could not connect. Will try again \
                    in 5 minutes.\n")

    if DEBUG and not error:
        sys.stdout.writelines(datetime.now().strftime("%m/%d/%Y %I:%M:%S:") + " Successfully updated weather\n")

if __name__ == '__main__':
    try:
        if environ['DEBUG']:
            DEBUG = True
    except KeyError:
        DEBUG = False

    if DEBUG:
        sys.stdout.writelines(datetime.now().strftime("%m/%d/%Y %I:%M:%S:") + " Updating weather\n")
    generate_forecast()
