from robot.api.deco import keyword


@keyword(name="Create Params Dictionary")
def create_dictionary_of_units_params(**kwargs: str) -> dict:
    """
    Create valid dictionary of parameters with units param anr return it
    :param kwargs: variable number of arguments like key=value
    :return: dictionary
    :raises ValueError: thrown if the current parameters are unknown
    """
    if "units" not in kwargs:
        kwargs["units"] = "standard"
    elif kwargs["units"] != "imperial" and kwargs["units"] != "metric":
        kwargs["units"] = "standard"
    return kwargs
