import datetime
from robot.api.deco import keyword


@keyword(name="Get Now")
def get_current_timestamp() -> int:
    """
    Get current time and return it
    :return: current time in ms
    """
    return int(datetime.datetime.now().timestamp())

