import random


def get_random_item_except_current_from_list(current, list_items):
    remove_item_from_list(current, list_items)
    random_item = get_random_from_list(list_items)
    return random_item


def get_random_from_list(list_items):
    return random.choice(list_items)


def remove_item_from_list(current, list_items):
    if current in list_items:
        return list_items.remove(current)
    else:
        return list_items


def default_param(param):
    if 'units' not in param:
        param['units'] = 'standard'
    elif param['units'] == "imperial":
        param['units'] = "imperial"
    elif param['units'] == "metric":
        param['units'] = "metric"
    elif param['units'] != "imperial" or param['units'] != "metric":
        param['units'] = "standard"
    return param
