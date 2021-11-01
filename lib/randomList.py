import random


def getRandomItemExceptCurrentFromList(current, listItems):
    removeItemFromList(current, listItems)
    randomItem = getRandomFromList(listItems)
    return randomItem


def getRandomFromList(listItems):
    return random.choice(listItems)


def removeItemFromList(current, listItems):
    if current in listItems:
        return listItems.remove(current)
    else:
        return listItems


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
