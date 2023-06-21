from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def check_dell_bios_updates():
    # URL de la page de support
    url = "https://www.dell.com/support/home/fr-fr/product-support/product/inspiron-16-5645-laptop/drivers"

    # Selenium WebDriver
    chrome_options = Options()
    # Navigateur en mode headless
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")
    # Chromium
    chrome_options.binary_location = "/usr/bin/chromium"

    # Chromedriver
    service = Service("/usr/bin/chromedriver")
    driver = webdriver.Chrome(service=service, options=chrome_options)

    try:
        # Charger la page
        driver.get(url)

        # Attendre que l'onglet "Pilotes et téléchargements" soit cliquable (10s)
        wait = WebDriverWait(driver, 3)
        drivers_tab = wait.until(EC.element_to_be_clickable((By.ID, "drivers")))
        drivers_tab.click()

        # Attendre que la ligne du BIOS apparaisse
        bios_row = wait.until(EC.presence_of_element_located((By.ID, "tableRow_W3068")))

        # Extraire les informations
        bios_title = bios_row.find_element(By.CLASS_NAME, "dl-desk-view").text.strip()
        release_date = bios_row.find_element(
            By.XPATH, "./td[contains(@class, 'sorting_2')]"
        ).text.strip()
        download_link = bios_row.find_element(
            By.CSS_SELECTOR, "a[id^='btnDwn-']"
        ).get_attribute("href")

        print(f"Titre : {bios_title}")
        print(f"Date de publication : {release_date}")
        print(f"Lien de téléchargement : {download_link}")

    except Exception as e:
        print(f"Erreur lors de la récupération des informations : {e}")

    finally:
        driver.quit()


if __name__ == "__main__":
    check_dell_bios_updates()
