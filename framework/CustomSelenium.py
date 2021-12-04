from robot.api.deco import keyword
from SeleniumLibrary import SeleniumLibrary


class CustomSelenium(SeleniumLibrary):
    @keyword(name="Get All Text From Element")
    def get_all_texts(self, locator: str) -> list:
        """
        :param locator: locator of Element
        :return: the text value of all elements identified by `locator`
        """
        return self._get_all_texts(locator)

    def _get_all_texts(self, locator):
        elements = self.find_elements(locator)
        texts = []
        for element in elements:
            if element is not None:
                texts.append(element.text)
        return texts if texts else None
