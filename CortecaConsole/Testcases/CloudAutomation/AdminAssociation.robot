*** Settings ***
Library         QWeb
Library         String
Library         Collections
Resource        ../../Resources/KeywordDefinition/adminpagekeywords.robot
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../../CortecaConsole/Locators/associationlocator.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/ConfigureBoengSSH.resource
Variables       ../../Resources/TestDatas.py

*** Test Cases ***

BBDT-196447_NWCC_L1_NWCC_specificfeature_Admin_SinglePointAssociation_01
    [Documentation]
    ...     Step 1: Action: In Admin dashboard -> WiFi point association -> Single point Association -> configure customerID without tenantname with device root MAC
    ...    Expected Result: Association should be success and toaster should show success
    ...     Step 2: Action: Check whether customerID is associated to provided MAC in validate section under wifi point association page - Provide customerID aloneExpected
    ...    Result: Success toaster should come like customerID <customerID> is associated with Wi-Fi point <Device MAC in upper case with hypen format>,For Automation: this also maps to
    ...    BBDT-196458    NWCC_L1_NWCC_specificfeature_Admin_ValidateAssociation_02 | MAC search to find associated customerID without tenantID in prefix
    ...    BBDT-196468     NWCC_L1_NWCC_specificfeature_Admin_Advancedeleting_06 | Delete a Wi-Fi point with customer account not available in DB
    ...    BBDT-196467    NWCC_L1_NWCC_specificfeature_Admin_Advancedeleting_05 | Delete a Wi-Fi point that belongs to a Customer
    
    Log To Console    define variable
    ${customerid}=    Set Variable    prepair1524
    ${password1}=    Set variable    12345678
    ${macaddress}=    Set variable    12-31-21-21-11-11
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Log To Console    assign the dummy mac so its assigned here
    Log To Console    wifi point provision dummy mac via api
    Run keyword and continue on failure    wifipoint_provision_API    ${macaddress}    ${password1}
    Log To Console    provision mac add the customer id
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    single_device_association    ${customerid}    ${macaddress}
    VerifyText    Success
    Log To Console     create keycloak account for the given mac
    ${customerid1}=    cloud_account_create    ${macaddress}
    Should Be Equal    ${cloudDetail}[tenant_name]_${customerid}    ${customerid1}
    validate_association    ${customerid}    ${macaddress}
    Verify Text    Success This association exists
    Log Screenshot
    delete_association    ${customerid}    None
    VerifyText    Success
    validate_association    None    ${macaddress}
    Verify Text    Error No CustomerID is associated to network device ${macaddress}
    Run keyword and continue on failure    Key_cloak_check    ${customerid}    No
    Log To Console    delete dummy mac from nwcc
    Run Keyword    Delete_mac_provision    ${macaddress}
    [Teardown]    Qw.closebrowser

BBDT-196448_NWCC_L1_NWCC_specificfeature_Admin_SinglePointAssociation_02
    ${customerid}=    Set Variable    prepair1524
    ${copy_macaddress}=    Create List
    ...    5E-50-41-B3-FE-A4
    ...    94-58-08-F5-D9-C8
    ...    23-D6-08-A8-F7-58
    ...    5E2E2DB86445
    ...    7d-eb-cf-a4-13-09
    ...    d3-4D-9e-D1-D3-E9
    ${macaddress}=    Create List
    ...    5E-50-41-B3-FE-A4
    ...    94-58-08-F5-D9-C8
    ...    23-D6-08-A8-F7-58
    ...    5E-2E-2D-B8-64-45
    ...    7D-EB-CF-A4-13-09
    ...    D3-4D-9E-D1-D3-E9
    ${password1}=    Create List    12345678    12345678    12345678    12345678    12345678    12345678
    ${length}=    Get Length    ${macaddress}
    Log    whitelist the all 5 extenders via API
    FOR    ${i}    IN RANGE    ${length}
        Run keyword and continue on failure    wifipoint_provision_API    ${macaddress}[${i}]    ${password1}[${i}]
    END
    ${join_macaddress}=    Evaluate    ",".join(${copy_macaddress})
    ${join_macaddress}=    Evaluate    ",".join(${macaddress})
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    single_device_association    ${customerid}    ${join_macaddress}
    VerifyText    Success
    log Screenshot
    validate_association    ${customerid}    None
    Run Keyword And Ignore Error
    ...    Is Text
    ...    Success Customer ID ${customerid} is associated with network device ${join_macaddress}
    validate_association    None    ${macaddress}[1]
    VerifyText
    ...    Success Network device ${macaddress}[1] is associated with CustomerID ${cloudDetail}[tenant_name]
    log Screenshot
    validate_association    None    ${macaddress}[4]
    VerifyText
    ...    Success Network device ${macaddress}[4] is associated with CustomerID ${cloudDetail}[tenant_name]
    log Screenshot
    Sleep    3s
    ${temp_mac_address}=    Set Variable    94-82-8A-5F-76-9B
    ${password1}=    Set Variable    12345678
    wifipoint_provision_API    ${temp_mac_address}    ${password1}
    single_device_association    ${customerid}    ${temp_mac_address}
    VerifyText    Error Max device count reached for the Customer ID ${cloudDetail}[tenant_name]_${customerid}
    log Screenshot
    Scroll    //html    down
    ${mac_to_be_deleted}=    Set Variable    D3-4D-9E-D1-D3-E9
    delete_association    ${customerid}    ${mac_to_be_deleted}
    VerifyText    Success
    Scroll    //html    page_up
    validate_association    None    ${mac_to_be_deleted}
    Sleep    2s
    VerifyText    Error No CustomerID is associated to network device ${mac_to_be_deleted}
    log Screenshot
    Scroll    //html    down
    delete_association    None    None
    verifyText    Success
    Refresh Page
    Sleep    3s
    validate_association    ${customerid}    None
    VerifyText    Error No network device is associated to Customer ID ${customerid}
    log Screenshot
    FOR    ${i}    IN RANGE    ${length}
        Run keyword and continue on failure    delete_mac_provision    ${macaddress}[${i}]
    END
    [Teardown]    Qw.closebrowser

BBDT-196449_NWCC_L1_NWCC_specificfeature_Admin_SinglePointAssociation_03
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    ${macaddress}=    Set variable    43-99-B3-7E-9B-48
    Run Keyword And Ignore Error    delete_mac_provision    ${macaddress}
    ${customerid}=    Set Variable    ${cloudDetail}[tenant_name]_prepair1524
    ${password1}=    Set variable    12345678
    single_device_association    ${customerid}    ${macaddress}
    VerifyText    Error Wi-Fi point 43-99-B3-7E-9B-48 is not provisioned
    log Screenshot
    validate_association    ${customerid}    ${macaddress}
    verifyText    Error This association does not exist
    log Screenshot
    delete_association    ${customerid}    ${macaddress}
    verifyText    Error Customer ID ${customerid} not found
    log Screenshot
    [Teardown]    Qw.closebrowser

BBDT-312861_NWCC_AIOC_USP_AdminDashboard_29_33_34
    [Documentation]
    ...    Step 1: Action: In Admin dashboard -> WiFi point association -> Single point Association -> configure customerID with tenantname,email with device root MAC
    ...    Expected Result: Association should be success and toaster should show success
    ...    Step 2: Action: Check whether customerID is associated to provided MAC in validate section under wifi point association page - Provide MAC, custID Expected
    ...    Result: Success toaster should come like Success This association exists
    ...    step 3: Action: Search for the user info in the portal using pre-associated E-mail/name
    ...    Result: Subscriber Details should be listed
    ...    Step 4: Action: Delete the Customer account and check the association should not be presen
    ...    Step 5: Search for the user info in the portal using pre-associated E-mail/name should not exist
    ...    BBDT-312861 NWCC_AIOC_USP_AdminDashboard_29 | Verify User Name input using Single WiFi Point Association using Portal
    ...    BBDT-312865 NWCC_AIOC_USP_AdminDashboard_33 | Verify History event for Account created and Update events
    ...    BBDT-312866 NWCC_AIOC_USP_AdminDashboard_34 | Verify Email pre-association to Customer ID
    [Tags]    Both
    ${macaddress}=    Set variable    ${Root}[mac1]
    Log To Console  Pre-req: Deleting Existing Account
    Run Keyword And Continue On Failure   DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]
    Log To Console    define variable
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    Log To Console    provision MAC,User Name,customer id in the Input field and save
    single_device_association    ${adminAssociation}[customerid]   ${macaddress}   ${adminAssociation}[tenantName]  ${adminAssociation}[email]
    VerifyText    Success
    Log to Console    Success : Subscriber Name and email as part of Device Association
    validate_association    ${adminAssociation}[customerid]    ${macaddress}
    Verify Text    Success This association exists
    Qw.closebrowser
    Log To Console    Onboarding Root to Establishing cloud connection
    Run Keyword And Continue On Failure    ConfigureBoeng
    Log to Console    Verify Subscriber Name pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]   ${macaddress}  Name
    Log to Console    Verify Email pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[email]   ${macaddress}   Email
    Log To Console     create keycloak account for the given mac with associated Name,Email
    Sleep    40s
    cloud_account_create    ${macaddress}   ${adminAssociation}[email]   ${adminAssociation}[tenantName]
    Log To Console   Verification of History event for Account created and Update events
    ${searchList} =    Create List    New account created with user: ${adminAssociation}[tenantName]    User ${adminAssociation}[tenantName] has updated the account
    Qweb.Event History Validation   @{searchList}     ${Root}[mac1]
    Log To Console   Delete Subscriber Account
    DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]
    Qw.closebrowser
    Sleep    30s
    Log To Console   Validate User Name association removed after reset from Association page
    LoginTobrowserqweb
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    validate_association    None    ${macaddress}
    Verify Text    Error No CustomerID is associated to network device ${macaddress}
    Qw.closebrowser
    Log To Console   Validate User Name association removed after reset from Subscriber page
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]    No data available.   Name
    [Teardown]    Qw.closebrowser

BBDT-312868_NWCC_AIOC_USP_AdminDashboard_36_39
    [Documentation]
    ...    Step 1: Action: In Admin dashboard -> WiFi point association -> Single point Association -> configure customerID with tenantname,email with device root MAC
    ...    Expected Result: Association should be success and toaster should show success
    ...    Step 2: Action: Check whether customerID is associated to provided MAC in validate section under wifi point association page - Provide MAC, custID Expected
    ...    Result: Success toaster should come like Success This association exists
    ...    step 3: Action: Search for the user info in the portal using pre-associated E-mail/name
    ...    Result: Subscriber Details should be listed
    ...    Step 4: Action: Create an account via MAPP API with different User name and Mail ID
    ...    Step 5: Search for the user info in the portal using pre-associated E-mail/name should not exist
    ...    Step 6: Action: Check for User Name and Email Overwrite function using below API Call.
    ...    Step 7: Search for the user info in the portal using updated E-mail/name via API call
    ...    PUT API – PUT https://l1api.stg.homewifi.nokia.com/subscribers/subscribers/?update_account=true
    ...    BBDT-312868 NWCC_AIOC_USP_AdminDashboard_36 | Verify User Name and Email overwrite using MAPP Account creation
    ...    BBDT-312871 NWCC_AIOC_USP_AdminDashboard_39 | Verify User Name and Email Update/Overwrite using API
    [Tags]    Both
    Log To Console  Pre-req: Deleting Existing Account
    Run Keyword And Continue On Failure   DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]
    Log To Console    define variable
    ${macaddress}=    Set variable    ${Root}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Log To Console    Moving to wifi-point-association page
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    Log To Console    provision MAC,User Name,customer id in the Input field and save
    single_device_association    ${adminAssociation}[customerid]    ${macaddress}   ${adminAssociation}[tenantName]  ${adminAssociation}[email]
    VerifyText    Success
    Log to Console    Success : Subscriber Name and email as part of Device Association
    validate_association    ${adminAssociation}[customerid]    ${macaddress}
    Verify Text    Success This association exists
    Qw.closebrowser
    Log To Console    Onboarding Root to Establishing cloud connection
    Run Keyword And Continue On Failure    ConfigureBoeng
    Log To Console     create keycloak account for the given mac with new Name,Email
    cloud_account_create    ${macaddress}  ${adminAssociation}[email_update]  ${adminAssociation}[tenantName_update]
    Sleep    300s
    Log To Console   Verification of History event for Account created and Update events
    ${searchList} =    Create List    New account created with user: ${adminAssociation}[tenantName]    User ${adminAssociation}[tenantName_update] has updated the account
    Run Keyword And Continue On Failure    Qweb.Event History Validation   @{searchList}     ${Root}[mac1]
    Log To Console   Validate new User Name association  after account creation from Subscriber page
    Qweb.Search Subscriber   ${adminAssociation}[tenantName_update]   ${macaddress}   Name
    Log to Console    Verify New Email pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[email_update]   ${macaddress}   Email
    Sleep    30s
    Log To Console   Updating account for the given mac with new Name,Email by UPDATE api call
    update_wifipoint_association_API   ${adminAssociation}[customerid]  ${macaddress}  ${adminAssociation}[tenantName_update_api]  ${adminAssociation}[email_update_api]
    Sleep    60s
    ${searchList} =    Create List     Account associated with Customer ID ${cloudDetail}[tenant_name]_${adminAssociation}[customerid] has changed the name: ${adminAssociation}[tenantName_update_api] and the email: ${adminAssociation}[email_update_api]
    Qweb.Event History Validation   @{searchList}     ${Root}[mac1]
    Log To Console   Validate new User Name association  after API Overwrite function call
    Qweb.Search Subscriber   ${adminAssociation}[tenantName_update_api]   ${macaddress}   Name
    Log to Console    Verify New Email pre-association to Customer ID after API Overwrite function call
    Qweb.Search Subscriber   ${adminAssociation}[email_update_api]   ${macaddress}   Email
    Log To Console   Delete Subscriber Account
    [Teardown]    DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]

BBDT-312862_NWCC_AIOC_USP_AdminDashboard_30
    [Documentation]
    ...    Step 1: Action: In Admin dashboard -> WiFi point association -> bulk Association -> configure customerID with tenantname,email with device root MAC in csv and upload it
    ...    Expected Result: Bulk Association should be success and toaster should show success
    ...    Step 2: Action: Check whether customerID is associated to provided MAC in validate section under wifi point association page - Provide MAC, custID Expected
    ...    Result: Success toaster should come like Success This association exists
    ...    step 3: Action: Search for the user info in the portal using pre-associated E-mail/name
    ...    Result: Subscriber Details should be listed
    ...    Step 4: Action: Delete the Customer account and check the association should not be presen
    ...    Step 5: Search for the user info in the portal using pre-associated E-mail/name should not exist
    ...    BBDT-312861 NWCC_AIOC_USP_AdminDashboard_30 | Verify User Name input using CSV in Bulk WiFi Point Association using Portal

    Log To Console  Pre-req: Deleting Existing Account
    Run Keyword And Continue On Failure   DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]
    Log To Console    define variable
    ${macaddress}=    Set variable    ${Root}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Log To Console    Moving to wifi-point-association page
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    Log To Console   Associate MAC,User Name,customer id via Bulk WiFi Point Association
    Log To Console    move to bulk upload
    ${File_name}=    Set Variable    ${supporting_path}\\mesh6.csv
    UploadFile    Choose File    ${File_name}
    Click Element    ${upload_button}
    VerifyText    Success mesh6.csv has been successfully uploaded.
    Log To Console   verified  the csv file upload with name input field success
    validate_association    ${adminAssociation}[customerid]    ${macaddress}
    Verify Text    Success This association exists
    Qw.closebrowser
    Log To Console    Onboarding Root to Establishing cloud connection
    Run Keyword And Continue On Failure    ConfigureBoeng
    Log to Console    Verify Subscriber Name pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]   ${macaddress}   Name
    Log to Console    Verify Email pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[email]   ${macaddress}   Email
    Log To Console     create keycloak account for the given mac with associated Name,Email
    cloud_account_create    ${macaddress}   ${adminAssociation}[email]   ${adminAssociation}[tenantName]
    Sleep    60s
    Log To Console   Verification of History event for Account created and Update events
    ${searchList} =    Create List    New account created with user: ${adminAssociation}[tenantName]    User ${adminAssociation}[tenantName] has updated the account
    Qweb.Event History Validation   @{searchList}     ${Root}[mac1]
    Log To Console   Delete Subscriber Account
    DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${customerid}
    Sleep    30s
    Log To Console   Validate User Name association removed after reset from Association page
    LoginTobrowserqweb
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    validate_association    None    ${macaddress}
    Verify Text    Error No CustomerID is associated to network device ${macaddress}
    Qw.closebrowser
    Log To Console   Validate User Name association removed after reset from Subscriber page
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]    No data available.   Name


BBDT-312863_NWCC_AIOC_USP_AdminDashboard_31
    [Documentation]
    ...    Action: Check if the user name can be associated using the below API call
    ...            Single WiFi Point API – POST https://l1api.stg.homewifi.nokia.com/subscribers/subscribers
    ...            Bulk WiFi Point API – POST https://l1api.stg.homewifi.nokia.com/subscribers/subscribers/upload
    ...    Result: 200 response code for API call
    ...    BBDT-312863 NWCC_AIOC_USP_AdminDashboard_31 | Verify User Name input using API for Single and Bulk Association

    Log To Console    define variable
    Log To Console  Pre-req: Deleting Existing Account
    Run Keyword And Continue On Failure   DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]
    Log To Console    define variable
    ${macaddress}=    Set variable    ${Root}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Log To Console    Moving to wifi-point-association page
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    Log To Console    Executing single wifipoint association API call
    single_wifipoint_association_API    ${adminAssociation}[customerid]    ${macaddress}   ${adminAssociation}[tenantName]  ${adminAssociation}[email]
    validate_association    ${adminAssociation}[customerid]    ${macaddress}
    Verify Text    Success This association exists
    Log To Console    Verified user name associated which uploaded via API
    Qw.closebrowser
    Log To Console    Onboarding Root to Establishing cloud connection
    Run Keyword And Continue On Failure    ConfigureBoeng
    Log to Console    Verify Subscriber Name pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]   ${macaddress}   Name
    Log to Console    Verify Email pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[email]   ${macaddress}   Email
    Log To Console   Delete Subscriber Account
    DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset_False}   ${adminAssociation}[customerid]
    Log To Console    Executing Bulk wifipoint association API call
    bulk_wifipoint_association_API
    Log to Console    Verify Subscriber Name pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[tenantName]   ${macaddress}   Name
    Log to Console    Verify Email pre-association to Customer ID
    Qweb.Search Subscriber   ${adminAssociation}[email]   ${macaddress}   Email
    Log To Console   Delete Subscriber Account
    DeleteSubscriberReset   ${API_URL_DeleteBeaconSubscriberReset}   ${adminAssociation}[customerid]

