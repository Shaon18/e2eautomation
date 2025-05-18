import uiautomator2 as u2


class WifiConnector:
    def __init__(self, uuid=None):
        if uuid:
            self.d = u2.connect(uuid)
        else:
            self.d = u2.connect()  # Connect to the device
        print(self.d.info)

    def open_wifi_settings(self):
        # Open the settings application
        self.d.app_start("com.android.settings")
        print("Opened Settings App")

        # Scroll and select "Network & internet"
        self.d(scrollable=True).scroll.to(text="Network & internet")
        self.d(text="Network & internet").click()

        # Select Wi-Fi
        self.d(text="Wi‑Fi").click()
        print("Opened Wi-Fi settings")

    def connect_to_wifi(self, network_name, password):
        # Wait until Wi-Fi networks are loaded
        self.d(scrollable=True).scroll.to(text=network_name)

        # Click on the Wi-Fi network
        self.d(text=network_name).click()

        # Enter the password if required
        if self.d(resourceId="com.android.settings:id/password"):
            self.d(resourceId="com.android.settings:id/password").set_text(password)
            self.d(text="Connect").click()
            print(f"Connecting to {network_name}")
        else:
            print(f"Connected to {network_name} without a password")

        # Confirm Wi-Fi connection status
        if self.d(text="Connected").exists:
            print(f"Successfully connected to {network_name}")

wifi_connector = WifiConnector()
wifi_connector.open_wifi_settings()
wifi_connector.connect_to_wifi("Your_WiFi_Network", "Your_WiFi_Password")
