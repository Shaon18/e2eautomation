*** Settings ***
Library           QWeb
Library           String
Library           Collections
Resource          ../../Resources/KeywordDefinition/adminpagekeywords.robot
Resource          ../../Resources/KeywordDefinition/ApiRequest.resource
Resource          ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables         ../../InputFiles/sampleSetupFileFormat_G-2425-GA.py
Variables         ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Variables         ../../Locators/provisionlocator.py

*** Test Cases ***
BBDT_196560_NWCC_L1_NWCC_specificfeature_Admin_SinglePointprovision_01
    Log To Console    delete the devices from the portal
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Root}[mac1]
    Log To Console    open the admin page
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Log To Console    check the nwcc toggle is enabled by default
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Log Screenshot
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]
    Log To Console    check the device show in online in the cloud
    Sleep    60s
    check_estd_console    ${Root}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Log To Console    Validate the provision device
    vadilateprovison    Yes    No    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    Log Screenshot
    deleteprovision    Yes    No    ${Root}[mac1]    No
    Verify Text    Success
    log Screenshot
    Log To Console    verify the deleted mac throws the error
    deleteprovision    Yes    No    ${Root}[mac1]    No
    Verify Text    Error Tenant not available for ${Root}[mac1]
    log Screenshot
    vadilateprovison    Yes    No    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    No
    Verify Text    Error Tenant not available for ${Root}[mac1]
    log Screenshot
    Log To Console    check the device plas/usp not establsh
    IF    '${DeviceStream}'=='HA'
        Sleep    10s
        ${ssh_output}=    SSHExecute     netstat -anp | grep -i plas
        Should Not Contain    Contain    ${ssh_output}    ESTABLISHED
    ELSE IF    '${DeviceStream}'=='USP'
        ${ssh_output}=   SSHExecute      cat /tmp/mqtt_nwcc_status
        Should Not Contain    ${ssh_output}    Connected
    END
    Sleep    15s
    [Teardown]    Qw.closebrowser

BBDT_196560_NWCC_L1_NWCC_specificfeature_Admin_SinglePointProvision_02
    API-CreateSession
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Root}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Log To Console    check the nwcc toggle is enabled by default
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    ${macaddress}=    Convert To Lower Case    ${macaddress}
    Log To Console    convert the lower case
    ...    No
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Log Screenshot
    Log    vadilate the hdm & nwcc
    vadilateprovison    Yes    Yes    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    Log Screenshot
    provision_get_api    ${Root}[mac1]    ${Root}[OUI]    ${Root}[Productclass]    ${Root}[serial_num]
    Sleep    15s
    cloudconnectioncheck
    Qw.closebrowser
    Sleep    30s
    check_estd_console    ${Root}[mac1]
    Log    delete hdm alone
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Log    vadilate the nwcc alone when hdm is deleted
    vadilateprovison    No    Yes    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    log Screenshot
    Log To Console    delete the hdm alone
    deleteprovision    No    Yes    ${macaddress}    No
    Verify Text    Success
    log Screenshot
    Log To Console    adding which already provisioned
    ${macaddress}=    Replace String    ${macaddress}    -    :
    singlepointprovision    No    Yes    No    ${macaddress}    ${password}    No
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    log screenshot
    vadilateprovison    Yes    Yes    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    log screenshot
    Qw.closebrowser
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Wait Until Keyword Succeeds    3x    1000ms    deleteprovision    Yes    Yes    ${macaddress}    No
    Verify Text    Success
    log Screenshot
    Log To Console    check the device plas/usp not establsh
    Sleep    30s
    cloudconnectioncheck
    Log To Console    provision nwccc already in hdm provision
    ${macaddress}=    Remove String    ${macaddress}    :
    Log To Console    ${macaddress}
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    log Screenshot
    Sleep    15s
    cloudconnectioncheck
    Qw.closebrowser
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Sleep    5s
    singlepointprovision    No    Yes    No    ${macaddress}    ${password}    No
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Log screenshot
    deleteprovision    Yes    Yes    ${macaddress}    No
    Log Screenshot
    [Teardown]    Qw.closebrowser

BBDT_196560_NWCC_L1_NWCC_specificfeature_Admin_SinglePointAssociation_03
    API-CreateSession
    Log To Console    delete the devices from the portal
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Root}[mac1]
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Ext1}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    Log To Console    check the nwcc toggle is enabled by default
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    Log To Console    remove the hypen
    ${macaddress}=    Remove String    ${macaddress}    -
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Log screenshot
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    Log screenshot
    deleteprovision    Yes    No    ${macaddress}    No
    ${macaddress}=    Convert To Lower Case    ${macaddress}
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    deleteprovision    Yes    No    ${macaddress}    No
    ${macaddress}=    Replace String    ${macaddress}    -    :
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Log screenshot
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    deleteprovision    Yes    No    ${macaddress}    No
    Log screenshot
    ${macaddress}=    Convert To Lower Case    ${macaddress}
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Log screenshot
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}    No
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    Sleep    2s
    deleteprovision    Yes    No    ${macaddress}    No
    Log screenshot
    Log To Console    Error scenario in the nwcc
    ${password}=    Set Variable    1234565678
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    No
    Sleep    3s
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}12345    No
    Verify Text    Error Password mismatch
    Log Screenshot
    ${macaddress}=    Set Variable    E0-1F-2B-B8-8F-12
    vadilateprovison    Yes    No    No    ${macaddress}    ${password}12345    No
    Verify Text    Error Tenant not available for E0-1F-2B-B8-8F-12
    Log Screenshot
    deleteprovision    Yes    No    ${macaddress}    No
    Verify Text    Error Tenant not available for E0-1F-2B-B8-8F-12
    Log Screenshot
    [Teardown]    Qw.closebrowser

Bulk_provision
    API-CreateSession
    Log To Console    delete the devices from the portal
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Root}[mac1]
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Ext1}[mac1]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    ${filepath}=    Set Variable    ${supporting_path}//normal_mac.csv
    Log To Console    ${filepath}
    bulkprovision_upload    Yes    No    No    No    ${filepath}
    Verify Text    Success normal_mac.csv has been successfully uploaded.
    Log To Console    verify the plas is established root & Ext
    Log To Console    root plas/ usp check
    Sleep    5s
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]
    Log To Console    check for extnders
    cloudconnectioncheck    ${Ext1}[ip]    ${Ext1}[telnet_vtysh]
    Log To Console    delete the root & extender
    deleteprovision    Yes    No    ${Root}[mac1]    No
    deleteprovision    Yes    No    ${Ext1}[mac1]    No
    Log To Console    provsion hdm alone
    ${filepath}=    Set Variable    ${supporting_path}//colon_small.csv
    bulkprovision_upload    No    Yes    No    No    ${filepath}
    Log Screenshot
    Verify Text    Success colon_small.csv has been successfully uploaded.
    vadilateprovison    No    Yes    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    No
    Log Screenshot
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    vadilateprovison    No    Yes    No    ${Ext1}[mac1]    ${Ext1}[ssid_defa_password]    No
    Log Screenshot
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    ${filepath}=    Set Variable    ${supporting_path}//small_outspace.csv
    bulkprovision_upload    Yes    No    No    No    ${filepath}
    Log Screenshot
    Verify Text    Success small_outspace.csv has been successfully uploaded
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]
    cloudconnectioncheck    ${Ext1}[ip]    ${Ext1}[telnet_vtysh]
    Refresh Page
    Sleep    6s
    deleteprovision    Yes    Yes    ${Root}[mac1]    No
    Verify Text    Success
    Sleep    5s
    deleteprovision    Yes    Yes    ${Ext1}[mac1]    No
    Verify Text    Success
    Sleep    5s
    Qw.closebrowser
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    ${filepath}=    Set Variable    ${supporting_path}//normal_mac.csv
    bulkprovision_upload    Yes    No    No    No    ${filepath}
    Verify Text    Success normal_mac.csv has been successfully uploaded.
    ${filepath}=    Set Variable    ${supporting_path}//without_hypen.csv
    bulkprovision_upload    Yes    No    No    No    ${filepath}
    Verify Text    Success without_hypen.csv has been successfully uploaded.
    provision_get_api    ${Root}[mac1]    ${Root}[OUI]    ${Root}[Productclass]    ${Root}[serial_num]
    Provision_get_api    ${Ext1}[mac1]    ${Ext1}[OUI]    ${Ext1}[Productclass]    ${Ext1}[serial_num]
    [Teardown]    Qw.closebrowser

MasterLogin
    API-CreateSession
    ${status1}=    Run Keyword And Ignore Error    delete_mac_provision    ${Root}[mac1]
    LoginTobrowsermaster
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    Yes
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Log Screenshot
    Sleep    10s
    Log To Console    vadilate the masteruser provision
    vadilateprovison    Yes    No    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    Yes
    Log Screenshot
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]
    Log To Console    check the device show in online in the cloud
    Sleep    60s
    check_estd_console    ${Root}[mac1]
    Qw.closebrowser
    LoginTobrowsermaster
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    deleteprovision    Yes    No    ${macaddress}    Yes
    Verify Text    Success
    Refresh Page
    Sleep    10s
    singlepointprovision    No    Yes    No    ${macaddress}    ${password}    Yes
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Sleep    3s
    Log Screenshot
    Qw.closebrowser
    LoginTobrowsermaster
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Verify Text    Network device provisioning
    singlepointprovision    Yes    No    No    ${macaddress}    ${password}    Yes
    Log    check plas or usp is estabilshed
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    Sleep    10s
    vadilateprovison    No    Yes    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    Yes
    Log Screenshot
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    deleteprovision    Yes    Yes    ${macaddress}    Yes
    Sleep    5s
    Verify Text    Success
    Refresh Page
    Sleep    15s
    singlepointprovision    Yes    Yes    No    ${macaddress}    ${password}    Yes
    Log    check plas or usp is estabilshed
    Log Screenshot
    VerifyText    Success ${Root}[mac1] network device has been successfully provisioned
    vadilateprovison    Yes    Yes    No    ${Root}[mac1]    ${Root}[ssid_defa_password]    Yes
    Log Screenshot
    Verify Text    Success Network device is provisioned to ${cloudDetail}[tenant_name]
    deleteprovision    Yes    Yes    ${macaddress}    Yes
    Log Screenshot
    Verify Text    Success
    [Teardown]    Qw.closebrowser

update_master_login
    Log To Console    update the console check
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    LoginTobrowsermaster
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Log To Console    changing tenant
    Click Text    nokiahwstg
    Click Element    ${click_tenantid2}
    Log To Console    updating provisioning
    Type Text    ${update_mac_address}    ${Root}[mac1]
    Click Element    ${update_button}
    Verify Text    Success
    Click Element    ${HomeMenuButton}
    Click Text    Home
    Click Element    ${MasterHomeDropdown}
    Click Element    ${Home_tenant2_dropdown}
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
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
    Click Element    ${HomeMenuButton}
    Click Text    Admin
    Log To Console    changing tenant
    Click Text        nokiahwstg
    Click Element    ${click_tenantid}
    Log To Console    updating provisioning
    Type Text    ${update_mac_address}    ${Root}[mac2]
    Click Element    ${update_button}
    sleep   10s
    Verify Text    Success
    Click Element    ${HomeMenuButton}
    Click Text    Home
    Click Element    ${MasterHomeDropdown}
    Click Element    ${Home_tenant3_dropdown}
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
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
    Click Element    ${HomeMenuButton}
    Click Text    Admin
    Log To Console    changing tenant
    Click Text    \    nokiahwstg
    Click Element    ${click_tenantid2}
    Log To Console    updating provisioning
    Type Text    ${update_mac_address}    ${Root}[mac3]
    Click Element    ${update_button}
    sleep   10s
    Verify Text    Success
    Click Element    ${HomeMenuButton}
    Click Text    Home
    Click Element    ${MasterHomeDropdown}
    Click Element    ${Home_tenant2_dropdown}
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
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
    Click Element    ${HomeMenuButton}
    Click Text    Admin
    Log To Console    changing tenant
    Click Text    \    nokiahwstg
    Click Element    ${click_tenantid}
    Log To Console    updating provisioning
    Type Text    ${update_mac_address}    ${Root}[mac4]
    Click Element    ${update_button}
    sleep   10s
    Verify Text    Success
    Click Element    ${HomeMenuButton}
    Click Text    Home
    Click Element    ${MasterHomeDropdown}
    Click Element    ${Home_tenant3_dropdown}
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
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

NWCC_L1_NWCC_specificfeature_Admin_Deleteprovisioning_
    Log To Console    update the console check
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    singlepointprovision    Yes No No 6C-C6-3B-17-4D-50 6751268414 No
    Sleep    5s
    vadilateprovison    Yes No No 6C-C6-3B-17-4D-50 6751268414 No
    Sleep    5s
    bulk_provision_delete    delete.csv
    Log To Console    check the root  not esatblised
    IF    '${DeviceStream}'=='HA'
    ${restart_plasmodium}
        Sleep    10s
        ${ssh_output}=   SSHExecute    netstat -anp | grep -i plas
        Should Not Contain    Contain    ${ssh_output}    ESTABLISHED
    ELSE IF    '${DeviceStream}'=='USP'
        ${ssh_output}=   SSHExecute    cat /tmp/mqtt_nwcc_status
        Should Not Contain    ${ssh_output}    Connected
    END
        IF    '${DeviceStream}'=='HA'
    ${restart_plasmodium}
        Sleep    10s
        ${ssh_output}=   SSHExecute    netstat -anp | grep -i plas
        Should Not Contain    Contain    ${ssh_output}    ESTABLISHED
    ELSE IF    '${DeviceStream}'=='USP'
        ${ssh_output}=   SSHExecute    cat /tmp/mqtt_nwcc_status
        Should Not Contain    ${ssh_output}    Connected
    END


Test12
    check_estd_console    ${Root}[mac1]