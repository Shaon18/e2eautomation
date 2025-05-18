#Locators for performance Report page
from CortecaConsole.Locators.AnalyticsWifipointLocators import download_csvButton

performance_report_link ='//a[normalize-space()="Performance report"]'

select_all_checkbox ='//thead/tr/th[1]/label'

download_performanceCsv_button= '//button[normalize-space()="Download .csv"]'

performace_page_calendar1 = '//input[@placeholder="Start date"]'

performace_page_calendar1_back = '//button[@aria-label="Previous Month"]'

performance_page_multiselect_input = '//chevrondownicon[@data-pc-section="triggericon"]//*[name()="svg"]'

performance_page_input_unselect_all = '//div[@role="checkbox"]'

performance_page_noise_input = '//span[normalize-space()="Noise"]'

performance_page_cloud_input = '//span[normalize-space()="Cloud disconnections"]'

performance_page_reboot_input = '//span[normalize-space()="Reboot"]'

performance_page_claim_input = '//span[normalize-space()="Claim"]'

performance_page_newWiFi_input = '//span[normalize-space()="New network devices"]'

performance_page_coverage_input = '//span[normalize-space()="Coverage"]'

performance_page_congestion_input = '//span[normalize-space()="Congestion (OBSS)"]'

performance_page_backhaul_input = '//span[normalize-space()="Backhaul Quality"]'
