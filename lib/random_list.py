import random
from robot.api.deco import keyword


@keyword(name="Get Random Item From List")
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
