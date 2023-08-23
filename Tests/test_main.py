from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
import time
import pytest


@pytest.fixture()
def launch_application():
    global driver
    driver = webdriver.Chrome()
    driver.get('https://gtjwn.csb.app/')
    driver.maximize_window()
    wait = WebDriverWait(driver, 10)
    wait.until(expected_conditions.presence_of_element_located((By.CSS_SELECTOR, "button[title='Next'")))
    print("Application launched successfully!")
    yield
    driver.close()

@pytest.mark.smoke()
def test_focus_on_first_event(launch_application):
    go_to_first_button = driver.find_element(By.XPATH, "//button[@title='Go to First']")
    go_to_first_attr_value = go_to_first_button.get_attribute('aria-disabled')
    previous_button = driver.find_element(By.XPATH, "//button[@title='Previous']")
    previous_attr_value = previous_button.get_attribute('aria-disabled')
    go_to_last_button = driver.find_element(By.XPATH, "//button[@title='Go to Last']")
    go_to_last_attr_value = go_to_first_button.get_attribute('aria-disabled')
    next_button = driver.find_element(By.XPATH, "//button[@title='Next']")
    next_attr_value = next_button.get_attribute('aria-disabled')
    time.sleep(5)
    assert go_to_first_attr_value == 'true' and previous_attr_value == 'true', "Focus is not on the first node on application launch"
    #     print("TC1 & 3: Pass, Focus is on the first node!")             # TC1 and 3 verification
    # else:
    #     print("TC1 & 3: Fail, Focus is not on the first node!")
    # driver.get_screenshot_as_png()


def test_next_event():
    # Iterates through the timeline events
    go_to_first_button = driver.find_element(By.XPATH, "//button[@title='Go to First']")
    go_to_first_attr_value = go_to_first_button.get_attribute('aria-disabled')
    previous_button = driver.find_element(By.XPATH, "//button[@title='Previous']")
    previous_attr_value = previous_button.get_attribute('aria-disabled')
    next_button = driver.find_element(By.XPATH, "//button[@title='Next']")
    next_attr_value = next_button.get_attribute('aria-disabled')
    timeline_events_list = driver.find_elements(By.XPATH, "//div[@data-testid='timeline-circle']")
    for event in timeline_events_list:
        event_date = event.get_attribute('aria-label')
#        print(f"{event_date}\n")
    next_button.click()
    if 'active' in timeline_events_list[1].get_attribute('class') and go_to_first_attr_value != 'true' and previous_attr_value != 'true':
        print("TC5 & 6: Pass, Focus is on the next (2nd) event and node/date highlights in yellow color!")    # TC 5 amd 6 verification
    else:
        print("TC5 & 6: Fail, Focus is not on the next (2nd) event")
    driver.get_screenshot_as_png()


def test_last_event():
    go_to_first_button = driver.find_element(By.XPATH, "//button[@title='Go to First']")
    go_to_first_attr_value = go_to_first_button.get_attribute('aria-disabled')
    previous_button = driver.find_element(By.XPATH, "//button[@title='Previous']")
    previous_attr_value = previous_button.get_attribute('aria-disabled')
    go_to_last_button = driver.find_element(By.XPATH, "//button[@title='Go to Last']")
    go_to_last_attr_value = go_to_first_button.get_attribute('aria-disabled')
    next_button = driver.find_element(By.XPATH, "//button[@title='Next']")
    next_attr_value = next_button.get_attribute('aria-disabled')
    go_to_last_button.click()
    if go_to_last_attr_value == 'true' and next_attr_value == 'true':       # TC4 and 8 verification
        print("TC4: Pass, Focus is on the last node!")
    else:
        print("TC4: Fail, Focus is not on the last node!")


def test_previous_event():
    previous_button = driver.find_element(By.XPATH, "//button[@title='Previous']")
    next_attr_value = previous_button.get_attribute('aria-disabled')
    go_to_last_button = driver.find_element(By.XPATH, "//button[@title='Go to Last']")
    go_to_last_attr_value = go_to_last_button.get_attribute('aria-disabled')
    previous_button.click()
    if go_to_last_attr_value != 'true' and next_attr_value != 'true':       # TC7 verification
        print("TC7: Pass, Focus is not on the last node!")
    else:
        print("TC7: Fail, Focus is still on the last node!")


def test_refresh():                             # TC9 verification
    go_to_first_button = driver.find_element(By.XPATH, "//button[@title='Go to First']")
    go_to_first_attr_value = go_to_first_button.get_attribute('aria-disabled')
    previous_button = driver.find_element(By.XPATH, "//button[@title='Previous']")
    previous_attr_value = previous_button.get_attribute('aria-disabled')
    driver.refresh()
    if go_to_first_attr_value == 'true' and previous_attr_value == 'true':
        print("TC 1,3 & 9: Pass, Focus is on the first node!")
    else:
        print("TC1 & 3: Fail, Focus is not on the first node!")

