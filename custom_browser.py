from selenium import webdriver


def get_chrome_options():
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")  # เอาออกถ้าจะดู UI
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("--disable-infobars")
    options.add_experimental_option(
        "prefs",
        {
            "credentials_enable_service": False,
            "profile.password_manager_enabled": False,
        },
    )
    return options
