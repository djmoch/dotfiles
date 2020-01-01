#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from datetime import datetime
import math
import os
import sys
import forecastio
import requests

def generate_forecast():
    error = False
    latitude = None
    longitude = None

    try:
        # I keep my api key for forecast.io in a separate text file so
        # I don't accidentally publish it anywhere.
        with open('forecastio_api.txt', 'r') as apifile:
            api_key = apifile.read()
            api_key = api_key.strip()

        try:
            with open('zipcode.txt', 'r') as zipcodefile:
                zipcode = zipcodefile.read()
                zipcode = zipcode.strip()
        except FileNotFoundError:
            zipcode = None

        if zipcode is None:
            # Resolving location from IP is always going to be a best
            # guess, but it's better than hardcoding location data
            latitude, longitude = requests.get('https://ipinfo.io'). \
                json()['loc'].split(',')
        else:
            try:
                with open('zipcodeapi_api.txt', 'r') as zipcodeapifile:
                    zipcodeapi_key = zipcodeapifile.read()
                    zipcodeapi_key = zipcodeapi_key.strip()
            except FileNotFoundError:
                sys.stdout.writelines(
                    datetime.now().strftime("%m/%d/%Y %I:%M:%S:") +
                    " Could not find zipcodeapi key\n")
                exit()

            location = requests.get('https://www.zipcodeapi.com/rest/' \
                + zipcodeapi_key + '/info.json/' + zipcode + \
                '/degrees').json()
            latitude = location['lat']
            longitude = location['lng']

        # Now we're ready to actually get the weather
        forecast = forecastio.load_forecast(api_key, latitude, longitude)

        current_temp = forecast.currently()
        day = forecast.daily()

        if 'LANG' in os.environ and \
                os.environ['LANG'].find('UTF-8') != -1:
            degree_symbol = "\u00b0"
        else:
            degree_symbol = ""

        temp = str(current_temp.temperature) + degree_symbol + " F"
        high = str(int(math.ceil(day.data[0].temperatureMax)))
        low = str(int(math.ceil(day.data[0].temperatureMin)))

        out_filename = os.path.join(
            os.environ['HOME'],
            'var/forecastio/current_forecast.txt'
        )

        with open(out_filename, 'w') as outfile:
            outfile.write(temp + ", " + str(current_temp.summary) + \
                    ", " + high + degree_symbol + "/" +low + \
                    degree_symbol + " F")
    except requests.exceptions.ConnectionError:
        error = True
        sys.stdout.writelines(
            datetime.now().strftime("%m/%d/%Y %I:%M:%S:") +
            " Could not connect. Will try again in 5 minutes.\n")

    if not error:
        sys.stdout.writelines(
            datetime.now().strftime("%m/%d/%Y %I:%M:%S:") +
            " Successfully updated weather\n")

if __name__ == '__main__':
    sys.stdout.writelines(
        datetime.now().strftime("%m/%d/%Y %I:%M:%S:") +
        " Updating weather\n")
    generate_forecast()
