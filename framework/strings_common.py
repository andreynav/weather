from robot.api.deco import keyword


@keyword(name="Get Split String")
def split_str(value: str, separator: str, returned_part: int) -> str:
    """
    Get splitted by delimiter part of string and return it
    :param value: existing string
    :param separator: the separator for string
    :param returned_part: the part of string after split which should be returned
    :return: the part of resulting string
    :raises ValueError: thrown if the current parameters are unknown
    """
    try:
        return value.split(separator)[returned_part]
    except ValueError:
        print("The current parameters are unknown")
