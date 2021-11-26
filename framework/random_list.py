import random
from typing import Optional
from robot.api.deco import keyword


@keyword(name="Get Random Item From List")
def get_random_item_from_list(list_items: list, except_item: Optional[str] = None) -> str:
    """
    Get random item from list and return it
    :param list_items: the list of items
    :param except_item: the item in the list of items that shouldn't be selected (optional parameter)
    :return: a random item from current list
    :raises ValueError: thrown if the current parameters are unknown
    """
    if except_item is None:
        return random.choice(list_items)
    elif except_item in list_items:
        list_items.remove(except_item)
        return random.choice(list_items)
    else:
        raise ValueError("The current combination of args isn't allowed")
