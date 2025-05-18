*** Settings ***
Library         QWeb
Library         String
Library         Collections
Resource        ../../Resources/KeywordDefinition/adminpagekeywords.robot
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../InputFiles/sampleSetupFileFormat_G-2425-GA.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Variables       ../../InputFiles/EnvironmentInput.py

*** Test Cases ***
BulkAssociation1
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${customerid}=    Set Variable    prepair1524
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    ${customerid}=    Set Variable    prepair1524
    VerifyText    Network device association
    Log To Console    check the mesh1.csv file upload
    Log To Console    move to bulk upload
    UploadFile    Choose File    C:\Users\ladmin\Desktop\e2eautomation-rohith_cloud_automation\e2eautomation\CortecaConsole\InputFiles\Supportingfiles\mesh1.csv
    Click Element    ${upload_button}
    VerifyText    Success mesh1.csv has been successfully uploaded.
#    Sleep    250s
    Run Keyword If    '${DeviceStream}'=='HA'    HA_bringup    ${Root}[ip]    ${Root}[telnet_vtysh]
#    Sleep    40s
    Log To Console     check the device is associated with customer accouunt
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    qwebelement.clicktext    Search
    Click Element    //td[contains(.,'${cloudDetail}[tenant_name]_${customerid}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    Qw.closebrowser
    Log To Console    delete the customer id
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    Sleep    3s
    delete_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot

bulkassociation2
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${customerid}=    Set Variable    prepair1524
    Log To Console    wait for CPE to up
    Sleep    250s
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    ${customerid}=    Set Variable    prepair1524
    VerifyText    Network device association
    Log To Console    check the mesh1.csv file upload
    Log To Console    move to bulk upload
    ${File_name}=    Set Variable    ${supporting_path}//mesh2.csv
    UploadFile    Choose File    ${File_name}
    Click Element    ${upload_button}
    VerifyText    Success mesh2.csv has been successfully uploaded.
    Sleep    250s
    HA_bringup    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    40s
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    qwebelement.clicktext    Search
    Click Element    //td[contains(.,'${cloudDetail}[tenant_name]_${customerid}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    Sleep    250s
    delete_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot

bulkassociation3
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${customerid}=    Set Variable    prepair1524
    Log To Console    wait for CPE to up
    Sleep    250s
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    ${customerid}=    Set Variable    prepair1524
    VerifyText    Network device association
    Log To Console    check the mesh1.csv file upload
    Log To Console    move to bulk upload
    ${File_name}=    Set Variable    ${supporting_path}//mesh3.csv
    UploadFile    Choose File    ${File_name}
    Click Element    ${upload_button}
    VerifyText    Success mesh3.csv has been successfully uploaded.
    Sleep    250s
    HA_bringup    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    40s
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    qwebelement.clicktext    Search
    Click Element    //td[contains(.,'${cloudDetail}[tenant_name]_${customerid}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    Sleep    250s
    delete_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot

bulkassociation4
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${customerid}=    Set Variable    prepair1524
    Log To Console    wait for CPE to up
    Sleep    250s
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    ${customerid}=    Set Variable    prepair1524
    VerifyText    Network device association
    Log To Console    check the mesh1.csv file upload
    Log To Console    move to bulk upload
    ${File_name}=    Set Variable    ${supporting_path}//mesh4.csv
    UploadFile    Choose File    ${File_name}
    Click Element    ${upload_button}
    VerifyText    Success mesh4.csv has been successfully uploaded.
    Sleep    250s
    HA_bringup    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    40s
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    qwebelement.clicktext    Search
    Click Element    //td[contains(.,'${cloudDetail}[tenant_name]_${customerid}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    Sleep    250s
    delete_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot

Bulkassociaton_5
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${customerid}=    Set Variable    prepair1524
    Log To Console    wait for CPE to up
    Sleep    250s
    LoginTobrowserqweb
    Log To Console    moving to admin page
    Qwebelement.clicktext    Admin
    Click Element    ${admin_association_select}
    ${customerid}=    Set Variable    prepair1524
    VerifyText    Network device association
    Log To Console    check the mesh1.csv file upload
    Log To Console    move to bulk upload
    ${File_name}=    Set Variable    ${supporting_path}//mesh5.csv
    UploadFile    Choose File    ${File_name}
    Click Element    ${upload_button}
    VerifyText    Success mesh5.csv has been successfully uploaded.
    Sleep    250s
    HA_bringup    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    20s
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${Root}[mac1]    Enter customer details
    qwebelement.clicktext    Search
    Click Element    //td[contains(.,'${cloudDetail}[tenant_name]_${customerid}')]
    Sleep    5s
    Log Screenshot
    Click Element    ${network_map}
    Sleep    1s
    Verify Text    Online
    Log Screenshot
    Log To Console    check the ip is assigned to the mac
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_MATCH}    INDEX    ${customerid}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=    Set To Dictionary    ${RetResponse.json()}
    Run Keyword And Continue on Failure    Should Be Equal    ${RetResponse}[ip]    10.10.10.11
    Sleep    250s
    Log To Console    delete the customer id
    delete_association    ${customerid}    ${macaddress}
    VerifyText    Success
    log Screenshot
