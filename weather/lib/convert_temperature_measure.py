from robot.api.deco import keyword


@keyword(name="Convert Measure Temperature")
def converting_measure_temperature_one_to_measure_temperature_two(temperature: float, current_measure: str,
                                                                  expected_measure: str) -> float:
    """
    Convert temperature of current measure to temperature of expected measure and return result
    :param temperature: the current temperature in current_measure
    :param current_measure: the measure of temperature
    :param expected_measure: the measure to which the current temperature should be converted
    :return: the temperature of expected measure
    :raises ValueError: thrown if the current parameters are unknown
    """
    kelvin_zero = 273.15
    converted_value = None
    try:
        if current_measure == "standard" and expected_measure == "metric":
            converted_value = round(temperature - kelvin_zero, 2)
        if current_measure == "standard" and expected_measure == "imperial":
            converted_value = round(((temperature - kelvin_zero) * 9/5 + 32), 2)
        if current_measure == "metric" and expected_measure == "standard":
            converted_value = round(temperature + kelvin_zero, 2)
        if current_measure == "metric" and expected_measure == "imperial":
            converted_value = round(temperature * 9/5 + 32, 2)
        if current_measure == "imperial" and expected_measure == "standard":
            converted_value = round(((temperature - 32) * 5/9) + 273.15, 2)
        if current_measure == "imperial" and expected_measure == "metric":
            converted_value = round(((temperature - 32) * 5/9), 2)
    except ValueError:
        print("The current combination doesn't allowed")
    return converted_value
