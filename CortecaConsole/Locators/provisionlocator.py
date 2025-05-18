#..............CloudRegression selectors..........................
provision_mac_address="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[1]//input[@class='pv-input large']"
provision_password="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[2]//input[@class='pv-input large']"
provision_oui="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[3]//input[@class='pv-input large']"
provision_productcode="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[4]//input[@class='pv-input large']"
provision_serial_number="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[5]//input[@class='pv-input large']"
network_map="//a[@title='Networks'][contains(.,'Networks')]"
status_check="//div[@class='pv-table']"

#validate
validate_macaddress="xpath=//app-validate-provision-pv[1]//pv-form-control[1]//input[@class='pv-input large']"
validate_password="xpath=//app-validate-provision-pv[1]//pv-form-control[2]//input[@class='pv-input large']"


delete_mac_address="xpath=//app-delete-provision-pv[1]//input[@class='pv-input large']"

#bulk
upload_button="(//span[@class='p-button-label ng-star-inserted'][contains(.,'Upload')])[1]"

#masteruser
choose_tenant_dropdown = "//span[@aria-label='nokiahwstg']"
provision_mac_address_master="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[1]//input[@class='pv-input large']"
provision_mac_address_pass    ="//pv-input[@formcontrolname='password']//input[@type='text']"
click_tenantid2= "//li[@aria-label='tenant2']"
click_tenantid="xpath=//li[@aria-label='tenant3']"
vadilate_mastermac="xpath=//div[contains(@class,'main-section-content')]/app-wifi-point-provisioning-page/div/app-validate-provision-pv/pv-card/div/div[2]/form/div[1]/div[2]/pv-form-control[1]/div/pv-input/div/input"
vadilate_masterpass="xpath=//div[contains(@class,'main-section-content')]/app-wifi-point-provisioning-page/div/app-validate-provision-pv/pv-card/div/div[2]/form/div[1]/div[2]/pv-form-control[2]/div/pv-input/div/input"
delete_masteruser_mac="xpath=//div[contains(@class,'main-section-content')]/app-wifi-point-provisioning-page/div/app-delete-provision-pv/pv-card/div/div[2]/form/div[1]/div[2]/pv-form-control[1]/div/pv-input/div/input"
nwwc_hdm_oui="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[3]//input[@class='pv-input large']"
nwcc_hdm_product="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[4]//input[@class='pv-input large']"
nwcc_hdm_serial_num="xpath=//app-single-point-provision-pv[@class='ng-star-inserted']//pv-form-control[5]//input[@class='pv-input large']"
#----update card---#
update_mac_address="xpath=//app-update-provision-pv[@class='ng-star-inserted']//input[@class='pv-input large']"
update_button = "//button[normalize-space()='Update']"
