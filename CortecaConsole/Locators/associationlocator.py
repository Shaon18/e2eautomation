
#_________________device_association___________________
customerid_input="xpath=//app-wifi-point-association[1]//pv-form-control[1]//pv-input[@class='ng-untouched ng-pristine ng-invalid']//input[@class='pv-input large']"
admin_association_select="xpath=//a[contains(@title,'CustomerID association')]"
mac_address_input_cus="xpath=(//input[contains(@type,'text')])[2]"
submit_device_single="xpath=//app-wifi-point-association[1]//button[@class='pv-button small flat primary']"


#________________update_associtation__________
update_customer_id="xpath=//app-update-wifi-assoc[@class='ng-star-inserted']//pv-input[@class='ng-untouched ng-pristine ng-invalid']//input[@class='pv-input large']"
update_new_customer_id="xpath=//app-update-wifi-assoc[@class='ng-star-inserted']//div[1]/pv-form-control[2]//input[@class='pv-input large']"
submit_update="xpath=//app-update-wifi-assoc[@class='ng-star-inserted']//button[@class='pv-button small flat primary']"
#___________validate_____________
validate_customer_id_alone="xpath=//app-assoc-validation[@class='ng-star-inserted']//p-tabpanel[1]//input[@class='pv-input large']"
validate_macaddress_assoc= "xpath=(//input[contains(@type,'text')])[10]"
validate_customer_id="xpath=//p-tabpanel[3]//pv-form-control[1]//input[@class='pv-input large']"
validate_macaddress_both="xpath=(//input[contains(@type,'text')])[12]"

#____________Advanced deleting______________
deleting_cus_address="xpath=//app-advanced-deleting[1]//p-tabpanel[1]//input[@class='pv-input large']"
deleting_cus_network="xpath=//app-advanced-deleting[1]//p-tabpanel[2]//form[@class='flex-column ng-untouched ng-pristine ng-invalid']/pv-form-control[1]//input[@class='pv-input large']"
deleting_cus_id_both="xpath=//form[2]//pv-form-control[1]//input[@class='pv-input large']"
deleting_cus_mac="xpath=//form[2]//pv-form-control[2]//input[@class='pv-input large']"
deleting_network_mac="xpath=//form[3]//input[@class='pv-input large']"
deleting_network_device="xpath=//span[contains(.,'Network devices')]"
delete_button_2="xpath=//app-advanced-deleting[1]//p-tabpanel[1]//button[@class='pv-button small flat primary']"
delete_button_3="xpath=//form[2]//button[@class='pv-button small flat primary']"
delete_button_4="xpath=//form[3]//button[@class='pv-button small flat primary']"

