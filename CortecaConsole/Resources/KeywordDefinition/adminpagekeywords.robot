*** Settings ***
Library         QWeb
Library         Process
Library         String
Library         Collections
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables       ../../InputFiles/EnvironmentInput.py
Variables       ../../Locators/CortecaConsoleLocators.py
Variables       ../../Locators/provisionlocator.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Variables       ../../Locators/associationlocator.py
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource


*** Keywords ***
singlepointprovision
    [Documentation]    Singlepointprovision card which has hdm, hash the password ,nwcc provision
    [Arguments]
    ...    ${HomeController}
    ...    ${HDM}
    ...    ${hash_the_password}
    ...    ${macaddress}
    ...    ${password}
    ...    ${master_user}
    Log To Console    verify the nwcc toggle enabled by default
    ${status}=      Qw.ExecuteJavaScript     ${nwcc_toggle_slider_check}
    Should Be True    ${status}
    log Screenshot
    IF    '${HomeController}'=='No'
        Execute JavaScript    ${nwcc_toggle_slider_click}
    END
    IF    '${HDM}'=='Yes'    Execute JavaScript    ${HDM_toggle_slider}
    IF    '${hash_the_password}'=='Yes'
        Execute JavaScript    ${hash_the_password}
    END
    qwebelement.typetext    ${macaddress}    ${provision_mac_address}
    IF    '${HomeController}'=='Yes' and '${HDM}'=='No'
        qwebelement.typetext    ${password}    ${provision_password}
    END
    Log To Console    for nwcc mac and passowrd alone needed
#    IF    '${HomeController}'=='No' and '${HDM}'=='Yes'
#    qwebelement.typetext    ${Root}[ssid_defa_password]    ${provision_password}
#    END
    IF    '${HomeController}'=='No' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[OUI]    ${nwwc_hdm_oui}
    END
    IF    '${HomeController}'=='No' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[Productclass]    ${nwcc_hdm_product}
    END
    IF    '${HomeController}'=='No' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[serial_num]    ${nwcc_hdm_serial_num}
    END
    Log To Console    HDM and nwcc enabled by true
    IF    '${HomeController}'=='Yes' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[ssid_defa_password]    ${provision_password}
    END
    IF    '${HomeController}'=='Yes' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[OUI]    ${provision_oui}
    END
    IF    '${HomeController}'=='Yes' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[Productclass]    ${provision_productcode}
    END
    IF    '${HomeController}'=='Yes' and '${HDM}'=='Yes'
        qwebelement.typetext    ${Root}[serial_num]    ${provision_serial_number}
    END
    Log To Console    masteruser single provision
    IF    '${masteruser}'=='Yes'
        ClickText    nokiahwstg
        Click Element    ${click_tenantid}
    END
    ClickText    Submit
    log Screenshot

check_estd_console
    [Arguments]
    ...    ${macaddress}
    ...    ${browserUrl}=${cloudDetail}[URL]
    ...    ${browser}=chrome
    ...    ${username}=${cloudDetail}[uname]
    ...    ${paswd}=${cloudDetail}[pswd]
    Open Browser    ${browserUrl}    ${browser}
    qwebelement.typetext    ${username}    username
    qwebelement.typetext    ${paswd}    password
    qwebelement.clicktext    login
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    log Screenshot
    Sleep    10s
    qwebelement.clicktext    Search
    Sleep    5s
    Log Screenshot
    Click Element    //td[contains(.,'${macaddress}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    [Teardown]    Qw.closebrowser

vadilateprovison
    [Documentation]    validate card which has hdm, hash the password ,nwcc provision
    [Arguments]
    ...    ${HomeController}
    ...    ${HDM}
    ...    ${hash_the_password}
    ...    ${macaddress}
    ...    ${password}
    ...    ${master_user}
    Log To Console    verify the nwcc toggle enabled by default
    ${status}=      Run Keyword And Return     Execute Javascript    ${validate_nwcc_slider_check}
    Should Be True    ${status}
    log Screenshot
    IF    '${HomeController}'=='No'
        Execute Javascript    ${validate_nwcc_slider_click}
    END
    IF    '${HDM}'=='Yes'    Execute Javascript    ${validate_hdm_slider}
    IF    '${hash_the_password}'=='Yes'
        Execute Javascript    ${validate_hash}
    END
    IF    '${master_user}'=='Yes'
        qwebelement.typetext    ${macaddress}    ${vadilate_mastermac}
        qwebelement.typetext    ${password}    ${vadilate_masterpass}
    ELSE
        qwebelement.typetext    ${macaddress}    ${validate_macaddress}
        qwebelement.typetext    ${password}    ${validate_password}
    END
    ClickText    Validate
    log Screenshot

deleteprovision
    [Arguments]
    ...    ${HomeController}
    ...    ${HDM}
    ...    ${macaddress}
    ...    ${master_user}
    Log To Console    delete the provision mac address
    Log To Console    verify the nwcc toggle enabled by default
    ${status} =  Run Keyword  Execute Javascript    ${validate_nwcc_slider_check}
    Should Be True    ${status}
    log Screenshot
    IF    '${HomeController}'=='No'
        Execute Javascript    ${delete_nwcc_slider}
    END
    IF    '${HDM}'=='Yes'    Execute Javascript    ${delete_hdm_slider}
    IF    '${master_user}'=='No'
        qwebelement.typetext    ${macaddress}    ${delete_mac_address}
    ELSE
        qwebelement.typetext    ${macaddress}    ${delete_masteruser_mac}
    END
    ClickText    Delete
    log Screenshot

bulkprovision_upload
    [Arguments]
    ...    ${HomeController}
    ...    ${HDM}
    ...    ${hash}
    ...    ${master_user}
    ...    ${File_name}
    Log To Console    delete the provision mac address
    Log To Console    verify the nwcc toggle enabled by default
    ${status}=   Run Keyword  Execute Javascript    ${validate_nwcc_slider_check}
    Should Be True    ${status}
    log Screenshot
    IF    '${HomeController}'=='No'
        Execute Javascript    ${NWCC_bulk_provision}
    END
    IF    '${HDM}'=='Yes'    Execute Javascript    ${HDM_bulk_provision}
    IF    '${hash}'=='Yes'    Execute Javascript    ${Hash_bulk_provision}
    UploadFile    Choose File    ${File_name}
    Sleep    3s
    IF    '${master_user}'=='Yes'
        qwebelement.typetext    tenant3    ${bulk_masteruser}
    END
    Click Element    ${upload_button}

LoginTobrowsermaster
    [Documentation]    This function will open the url provided with the given browser
    ...    - Argument1: browserUrl-> URL of the site
    ...    - Argument2: browser-> Browser in which url need to be open. eg: Chrome.
    [Arguments]
    ...    ${browserUrl}=${masteruser}[URL]
    ...    ${browser}=chrome
    ...    ${username}=${masteruser}[uname]
    ...    ${paswd}=${masteruser}[pswd]
    ...    ${textToCheck}=Dashboards
    ${result} =    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
    Open Browser    ${browserUrl}    ${browser}
    # set config delay executing keywords by 1.5 seconds
    SetConfig    Delay    0.5s
    # Open Browser    ${browserUrl}    Chrome
    SetConfig    RetryInterval    2s
    Maximize Window
    # retry the same keywords again after 2s seconds
    qwebelement.typetext    ${username}    username
    qwebelement.typetext    ${paswd}    password
    qwebelement.clicktext    login

single_device_association
    [Arguments]    ${customerid}    ${macaddress}  ${tenantName}=None  ${email}=None
    Log To Console    enter the customer id
    qwebelement.typetext    ${customerid}    ${customerid_input}
    Qwebelement.typetext    ${macaddress}    ${mac_address_input_cus}
    IF  '${tenantName}' != 'None'
         Qwebelement.typetext    ${tenantName}    ${tenantName_input}
    END
    IF  '${email}' != 'None'
         Qwebelement.typetext    ${email}    ${email_input}
    END
    log Screenshot
    ClickElement    ${submit_device_single}


validate_association
    [Arguments]    ${customerid}    ${macaddress}  ${tenantName}='None'
    Log To Console    enter the customer id
    IF    '${customerid}'!='None' and '${macaddress}'!='None'
        qwebelement.clicktext    Customer ID and MAC Address
        log Screenshot
    END
    IF    '${customerid}'!='None' and '${macaddress}'=='None'
        qwebelement.typetext    ${customerid}    ${validate_customer_id_alone}
    END
    IF    '${customerid}'=='None' and '${macaddress}'!='None'
        qwebelement.clicktext    MAC Address
    END
    IF    '${customerid}'=='None' and '${macaddress}'!='None'
        qwebelement.typetext    ${macaddress}    ${validate_macaddress}
    END
    IF    '${customerid}'!='None' and '${macaddress}'!='None'
        qwebelement.typetext    ${customerid}    ${validate_customer_id}
    END
    IF    '${customerid}'!='None' and '${macaddress}'!='None'
        qwebelement.typetext    ${macaddress}    ${validate_macaddress_both}
    END
    Qwebelement.clicktext    Validate
    log Screenshot

delete_association
    [Arguments]    ${customerid}    ${macaddress}
    ${customer_temp} =    Set Variable    prepair1524
    IF    '${customerid}'!='None' and '${macaddress}'=='None'
        qwebelement.typetext    ${customerid}    ${deleting_cus_address}
        Qwebelement.clicktext    Delete
        log Screenshot
    END
    IF    '${customerid}'!='None' and '${macaddress}'!='None'
        Log To Console    no customerid assoc
        Click Element    ${deleting_network_device}
        qwebelement.typetext    ${customerid}    ${deleting_cus_id_both}
        qwebelement.typetext    ${macaddress}    ${deleting_cus_mac}
        ClickElement    ${delete_button_3}
        log Screenshot
    END
    IF    '${customerid}'=='None' and '${macaddress}'=='None'
        Log To Console    the mac address alone not the customerid
        Sleep    2s
        Click Element    ${deleting_network_device}
        qwebelement.typetext    ${customer_temp}    ${deleting_cus_network}
        ClickElement    ${delete_button_2}
        log Screenshot
    END
    IF    '${customerid}'=='None' and '${macaddress}'!='None'
        Click Element    ${deleting_network_device}
        qwebelement.typetext    ${macaddress}    ${deleting_network_mac}
        ClickElement    ${delete_button_3}
        log Screenshot
    END

key_cloak_check
    [Arguments]    ${customerid}    ${check}    ${browser}=chrome
    ${username} =    Set Variable    ${Keycloak}[uname]
    ${password} =    Set Variable    ${Keycloak}[pswd]
    ${browserUrl} =    Set Variable    ${Keycloak}[URL]
    Open Browser    ${browserUrl}    ${browser}
    Maximize Window
    qwebelement.typetext    ${username}    username
    qwebelement.typetext    ${password}    password
    qwebelement.clicktext    login
    qwebelement.clicktext    Users
    qwebelement.typetext    ${customerid}    Search user
    log Screenshot
    Sleep    5s
    log Screenshot
    PressKey    ${EMPTY}    {ENTER}
    IF    '${check}'!='Yes'
        Is No Text    ${cloudDetail}[tenant_name]${customerid}
    END
    IF    '${check}'=='Yes'
        Is No Text    ${cloudDetail}[tenant_name]${customerid}
    END

bulk_provision_delete
    [Arguments]    ${csvpath}
    Upload File    Choose File    ${csvpath}    anchor= deletion
    Click Element
    ...    xpath=//button[@class='p-ripple p-element p-button p-component']//span[@class='p-button-label ng-star-inserted'][normalize-space()='Upload']
    Verify Text    text= delete.csv has been successfully uploaded    timeout=20s

associationteardown
    [Arguments]    ${customerid}
    delete_association    ${customerid}    None
    bringup_setup
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]
