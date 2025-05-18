import uiautomator2 as u2
import logging
import time




PACKAGE_NAME = "com.nokia.wifi"
# ---------- Logging Setup ----------
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),  # Console output
        logging.FileHandler("test_log.txt")  # Optional file logging
    ]
)
def connect_ssid(uuid,ssid_name,ssid_pass):
    try:
        logging.info("Connecting to device: %s", uuid)
        d = u2.connect(uuid)
        d.screen_on()
        d.open_quick_settings()
        time.sleep(2)
        if d(descriptionContains="Wi-Fi").wait(timeout=5):
            d(descriptionContains="Wi-Fi").long_click()
            logging.info("Wi-Fi settings clicked.")
        else:
            logging.info("Wi-Fi settings not found!")
        time.sleep(5)
        # Locate the switch
        switch = d(resourceId="com.android.settings:id/switch_widget")

        # Wait for it to appear
        if switch.wait(timeout=5):
            state = switch.info.get("checked", False)  # True if ON, False if OFF
            logging.info("Switch is ON" if state else "Switch is OFF")
            time.sleep(5)
            if not state:
                switch.click()
                state = switch.info.get("checked", False)  # True if ON, False if OFF
                logging.info("Switch is ON" if state else "Switch is OFF")

        else:
            logging.info("Switch not found")
        time.sleep(5)

        if d(text=ssid_name).exists:
            logging.info("Found 'SSID' button.")
            d(text=ssid_name).click()
            time.sleep(5)
            if d(text="Connected").exists:
                logging.info("Found 'Connected' button.")
            else:
                if d(className="android.widget.EditText").exists:
                    logging.info("Found 'Password' placeholder.")
                    d(className="android.widget.EditText").set_text(ssid_pass)
                    time.sleep(5)
                    d.screenshot("password_set.png")
                    if d(text="CONNECT").exists:
                        logging.info("Found 'Connect' button.")
                        d(text="CONNECT").click()
                        if d(text="Connected").wait(timeout=10):
                            logging.info("Successfully connected")
                            d.screenshot("Connected_Text.png")
                        else:
                            raise Exception("Worng password")
                    else :
                        logging.info("Connext button not found")

        else:
            logging.info("SSID not found")
    except Exception as e:
        logging.exception("Exception during inputemailpass: %s", e)
        
def inputemailpass(uuid, username, password):


    try:
        logging.info("Connecting to device: %s", uuid)
        d = u2.connect(uuid)
        d.screen_on()

        time.sleep(10)
        d.app_start(PACKAGE_NAME)
        logging.info("Started app: %s", PACKAGE_NAME)

        time.sleep(10)

        # -------- Sign In --------

        if d(text="Sign In").exists:
            logging.info("Found 'Sign In' button.")
            d(text="Sign In").click()
        else:
            logging.error("'Sign In' button not found.")
            d.screenshot("error_signin_not_found.png")

        # -------- Get Started
        d(text="Get Started").wait(timeout=10)
        if d(text="Get Started").exists:
            logging.info("Found 'Get Started' button.")
            d(text="Get Started").click()
        else:
            logging.info("'Get Started' button not found.")
            d.screenshot("error_getstarted_not_found.png")


        # -------- Enter Email - -------
        d(className="android.widget.EditText")[0].wait(timeout=600)
        if d(className="android.widget.EditText")[0].exists:
          logging.info("Email input field found.")
          time.sleep(5)
          d(className="android.widget.EditText")[0].set_text(username)
          time.sleep(2)
          d.screenshot("email_found.png")
        else:
          logging.error("Email input field not found.")
          d.screenshot("error_email_input_not_found.png")


        # -------- Enter Password --------
        if d(className="android.widget.EditText")[1].exists:
          logging.info("Password input field found.")
          time.sleep(2)
          d(className="android.widget.EditText")[1].set_text(password)
          time.sleep(2)
          d.screenshot("password_found.png")
        else:
          logging.error("Password input field not found.")
          d.screenshot("error_password_input_not_found.png")


        # -------- Click Sign In/Submit --------
        if d(className="android.widget.Button")[1].exists:
          logging.info("Submit button found.")
          d(className="android.widget.Button")[1].click()
          time.sleep(5)
        else:
          logging.error("Submit button not found.")
          d.screenshot("error_submit_button_not_found.png")
        time.sleep(10)
        if d(text="Home").exists:
            logging.info("Found 'Home' page.")
            d.screenshot("Home_page.png")
            logging.info("Login completed successfully.")
        else:
            logging.error("Wrong credential")
        time.sleep(10)
        d.app_stop(PACKAGE_NAME)



    except Exception as e:
        logging.exception("Exception during inputemailpass: %s", e)



def checkdatacollection(uuid,username,passwd):
    logging.info("Connecting to device: %s", uuid)
    d = u2.connect(uuid)
    d.screen_on()

    time.sleep(10)
    d.app_start(PACKAGE_NAME)
    logging.info("Started app: %s", PACKAGE_NAME)
    time.sleep(10)
    if d(text="Sign In").exists():
        if d(text="Sign In").exists():
            logging.info("Found 'Sign In' button.")
            d(text="Sign In").click()
        else:
            logging.error("'Sign In' button not found.")
            d.screenshot("error_signin_not_found.png")

        # -------- Get Started
        d(text="Get Started").wait(timeout=10)
        if d(text="Get Started").exists:
            logging.info("Found 'Get Started' button.")
            d(text="Get Started").click()
        else:
            logging.info("'Get Started' button not found.")
            d.screenshot("error_getstarted_not_found.png")

        # if let's sign in to ur account page exists
        if d(text="Let's sign in to your account.").wait(timeout=600) or d(className="android.widget.EditText")[0].wait(timeout=600):
          if  d(text="Let's sign in to your account.").exists():
              logging.info(" Clicking next on Let's sign in to your account page")
              d(text="Next").click()
          else:

        # -------- Enter Email - -------
             if d(className="android.widget.EditText")[0].exists:
                logging.info("Email input field found.")
                time.sleep(5)
                d(className="android.widget.EditText")[0].set_text(username)
                time.sleep(2)
                d.screenshot("email_found.png")
             else:
                 logging.error("Email input field not found.")
                 d.screenshot("error_email_input_not_found.png")


        # -------- Enter Password --------
             if d(className="android.widget.EditText")[1].exists:
                logging.info("Password input field found.")
                time.sleep(2)
                d(className="android.widget.EditText")[1].set_text(passwd)
                time.sleep(2)
                d.screenshot("password_found.png")
             else:
                logging.error("Password input field not found.")
                d.screenshot("error_password_input_not_found.png")


        # -------- Click Sign In/Submit --------
             if d(className="android.widget.Button")[1].exists:
                logging.info("Submit button found.")
                d(className="android.widget.Button")[1].click()
                time.sleep(5)
             else:
                logging.error("Submit button not found.")
                d.screenshot("error_submit_button_not_found.png")
        time.sleep(10)
        if d(text="Device collection is off").exists:
            logging.info("Device collection is off")
            d.screenshot("DeviceCollection.png")
            return False
        else:
            logging.info("Device collection is ON")
            d.screenshot("DeviceCollection.png")
            return True
    else:
        time.sleep(10)
        if d(text="Device collection is off").exists:
            logging.info("Device collection is off")
            d.screenshot("DeviceCollection.png")
            return False
        else:
            logging.info("Device collection is ON")
            d.screenshot("DeviceCollection.png")
            return True
