from robot.api.deco import keyword
from datetime import datetime
import time


@keyword(name="Get Current Date")
def get_current_date_in_format(date_format: str) -> str:
    """
    Get the current date and return it in specific format
    :param date_format: the specific date format i.e "%m/%d/%Y, %H:%M:%S" or "%b %d"
    :return: date in specific format
    :raises ValueError: thrown if the current parameters are unknown
    """
    now_minsk_tz = datetime.fromtimestamp(time.time())
    return now_minsk_tz.strftime(date_format)


@keyword(name="Get Date From Timestamp In Format")
def get_formatted_date_in_format(timeStamp: int, date_format: str) -> str:
    """
    Get the formatted date and return it in specific format
    :param timeStamp: the specific date in timestamp format (ms)
    :param date_format: the specific date format i.e "%m/%d/%Y, %H:%M:%S" or "%b %d"
    :return: date in specific format
    :raises ValueError: thrown if the current parameters are unknown
    """
    date = datetime.fromtimestamp(timeStamp)
    return date.strftime(date_format)
