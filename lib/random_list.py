import random


def get_random_item_from_list(list_items, except_item=None):
    """ Get random item from list and return it
    :param str list_items: the list of items
    :param str except_item: the item in the list of items that shouldn't be selected (optional)
    :return: a random item from current list
    :rtype: str
    :raises ValueError: thrown if the current parameters are unknown
    """
    try:
        if except_item is None:
            return random.choice(list_items)
        if except_item in list_items:
            list_items.remove(except_item)
            return random.choice(list_items)
    except ValueError:
        print("The current parameters are unknown")


def default_param(param):
    try:
        if 'units' not in param:
            param['units'] = 'standard'
        elif param['units'] == "imperial":
            param['units'] = "imperial"
        elif param['units'] == "metric":
            param['units'] = "metric"
        elif param['units'] != "imperial" or param['units'] != "metric":
            param['units'] = "standard"
    except ValueError:
        print("The current parameters are unknown")
    return param
