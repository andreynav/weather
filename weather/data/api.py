URL_DOMAIN = "openweathermap.org"
URL_MAIN = f"https://{URL_DOMAIN}"
URL_HOME = f"https://home.{URL_DOMAIN}"
URL_LOGIN = f"{URL_HOME}/users/sign_in"
URL_PROFILE = f"{URL_HOME}/home"
API_BASE_URL = f"http://api.{URL_DOMAIN}/data/2.5"
API_ENDPOINT_WEATHER = f"{API_BASE_URL}/weather"
API_ENDPOINT_ONECALL = f"{API_BASE_URL}/onecall"
APP_ID = '3fb4953a99791aad09b7b1081c87f346'
DICT__UNITS = {"standard": 'KELVIN',
               "metric": "CELSIUS",
               "imperial": 'FAHRENHEIT'}
CODE_SUCCESS = '200'
BELMOPAN = 'Belmopan, BZ'
BELMOPAN_ID = '3582672'
DICT__COORD_BELMOPAN = {"lon": "-88.7667", "lat": "17.25"}
DICT__JSON_PATH = {"name": "$.name",
                   "lon": "$.coord.lon",
                   "lat": "$.coord.lat",
                   "temperature": "$.main.temp"}
MANCHESTER = 'Manchester, GB'
MANCHESTER_ID = '3582672'
DICT__COORD_MANCHESTER = {"lon": "-2.2374", "lat": "53.4809"}
DICT__ONECALL_JSON_PATH = {"list_dates": "$.daily[*][dt]",
                           "list_icons": "$.daily[*][weather][*][icon]",
                           "list_temp_max": "$.daily[*][temp][max]",
                           "list_temp_min": "$.daily[*][temp][min]",
                           "list_description": "$.daily[*][weather][*][description]"}
