from robot.api.deco import keyword


@keyword(name="Create Params Dictionary")
def create_dictionary_of_units_params(**kwargs: str) -> dict:
    """
    Create valid dictionary of parameters with units param anr return it
    :param kwargs: variable number of arguments like key=value
    :return: dictionary
    :raises ValueError: thrown if the current parameters are unknown
    """
    try:
        if "units" not in kwargs:
            kwargs["units"] = "standard"
        elif kwargs["units"] == "imperial":
            kwargs["units"] = "imperial"
        elif kwargs["units"] == "metric":
            kwargs["units"] = "metric"
        elif kwargs["units"] != "imperial" or kwargs["units"] != "metric":
            kwargs["units"] = "standard"
        return kwargs
    except ValueError:
        print("The current parameters are unknown")
