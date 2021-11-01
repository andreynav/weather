import random

def getRandomItemExceptCurrentFromList(current, list):
    newList = removeItemfromList(current, list)
    randomItem = getRandomFromList(list)
    return randomItem

def getRandomFromList(list):
    return random.choice(list)

def removeItemfromList(current, list):
    if current in list:
        return list.remove(current)
    else:
        return list;

def defaultParam(param):
    if 'units' not in param:
        param['units'] = 'standard'
    elif param['units'] == "imperial":
        param['units'] = "imperial"
    elif param['units'] == "metric":
        param['units'] = "metric"
    elif param['units'] != "imperial" or param['units'] != "metric":
        param['units'] = "standard"
    return param
