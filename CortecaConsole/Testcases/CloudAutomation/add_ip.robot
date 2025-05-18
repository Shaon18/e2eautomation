*** Settings ***
Library           QWeb
Library           String
Library           Collections
Library           Retry
Resource          ../../Resources/KeywordDefinition/adminpagekeywords.robot
Resource          ../../Resources/KeywordDefinition/ApiRequest.resource
Resource          ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables         ../../InputFiles/sampleSetupFileFormat.py
Variables         ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py

*** Test Cases ***
Add_ip
    [Documentation]    Step1: Action: Create account in keycloak via MAPP with root and 1 extender which is online in cloud
    ...
    ...    Expected Result: Association should be success
    ...
    ...    Step2: Action: For existing UUID add IP field and value via below API curl -X PUT "https://l1api.stg.homewifi.nokia.com/subscribers/subscribers/?update_account=true" -H "accept: /" -H "Authorization: Bearer" -H "Content-Type: application/json" -d " {\"home_wifis\":[\"38-A0-67-92-79-01\"],\"ip\":\"10.10.10.11\",\"uuid\":\"nokia95757\"}"
    ...
    ...    Expected Result: API - Get /subscribers/{uuid} should have IP parameter and configured value in response
    ...    BBDT-196471
    ...    NWCC_L1_NWCC_specificfeature_Admin_AddIP_01 | Add IP for existing UUID
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    VerifyText    Network device association
    ${customerid}=    Set Variable    prepair1524
    ${macaddress}=    Set Variable    ${Root}
    Log To Console    associate the devices with customerid
    single_device_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot
    Log To Console    assign the ip to homewifiid via api
    ${content}=    AddIPAddressAPI    ${customerid}    ${macaddress}
    Log To Console    ${content}
    Log To Console    verify the ip added to the mac
    CheckIpaddressAPI    ${customerid}
    [Teardown]    associationteardown    ${customerid}}
