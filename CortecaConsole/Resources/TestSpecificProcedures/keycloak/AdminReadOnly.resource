*** Settings ***
Library         String
Library         Collections
Library         QWeb
Library         Process
Library         DateTime
Variables       ../../../Locators/keycloak.py
Variables       ../../../Locators/CortecaConsoleLocators.py
Variables       ../../../InputFiles/EnvironmentInput.py
Resource        ../../KeywordDefinition/Qtwebkeywords.resource
Variables            ../../TestDatas.py


*** Keywords ***
check admin page options
    VerifyText    Provisioning    15s
    VerifyText    CustomerID association    15s
    VerifyText    Deployment reports    15s
    LogScreenshot

Provisioning
    Qwebelement.clicktext    Provisioning
    LogScreenshot
    VerifyText    Provisioning of a single network device    15s
    Qwebelement.typetext    ${Root}[mac]    ${networkmac}
    Qwebelement.typetext    ${Root}[ssid_defa_password]    ${netpass}
    ${class1}=    Get Attribute    ${submit_provision}    disabled
    Should Not Be True    ${class1}
    LogScreenshot
    VerifyText    Bulk provisioning of network devices    15s
    Qwebelement.typetext    ${Root}[mac]    ${valmac}
    Qwebelement.typetext    ${Root}[ssid_defa_password]    ${valpass}
    ${class2}=    Get Attribute    ${netvalidate}    disabled
    Should Not Be True    ${class2}
    LogScreenShot
    VerifyText    Delete a provisioned network device    15s
    Qwebelement.typetext    ${Root}[mac]    ${delmac}
    ${class3}=    Get Attribute    ${deletebutton}    disabled
    Should Not Be True    ${class3}
    LogScreenshot
    VerifyText    Bulk provisioning of network devices    15s
    Scroll Text    Bulk provisioning of network devices
    UploadFile    Choose File    ${supporting_path}\normal_mac.csv
    LogScreenshot
    ${class4}=    Get Attribute    ${uploadprov}    disabled
    Should Not Be True    ${class4}
    VerifyText    Bulk deletion of provisioned network devices    15s
    Scroll Text   Bulk deletion of provisioned network devices
    UploadFile    Choose File    ${supporting_path}\normal_mac.csv
    LogScreenshot
    ${class5}=    Get Attribute    ${uploaddeletion}    disabled
    Should Not Be True    ${class5}


CustomerIDAssociation
    Qwebelement.clicktext    CustomerID association
    LogScreenshot
    Verify Text    Network device association
    Qwebelement.typetext    ${Root}[mac]    ${ndmac}
    Qwebelement.typetext    ${default_text1}            ${ndcust}
    ${class11}=    Get Attribute    ${submit1}    disabled
    LogScreenshot
    Should Not Be True    ${class11}
    Verify Text   Update network device association
    Qwebelement.typetext    ${default_text1}     ${newcust}   
    Qwebelement.typetext    ${default_text1}     ${oldcust}
    ${class12}=    Get Attribute    ${submit2}    disabled
    LogScreenshot
    Should Not Be True    ${class12}
    Verify Text   Bulk network device association
    Scroll Text    Bulk network device association
    UploadFile    Choose File    ${supporting_path}/normal_mac.csv
    ${class13}=    Get Attribute    ${delupload}    disabled
    LogScreenshot
    Should Not Be True    ${class13}
    Verify Text   Validate
    Qwebelement.typetext    ${default_text1}    ${valcust}
    ${class14}=    Get Attribute    ${validate1}    disabled
    LogScreenshot
    Should Not Be True    ${class14}
    Verify Text   Advanced deleting
    Qwebelement.typetext    ${default_text1}    ${delcust}
    ${class15}=    Get Attribute    ${dele1}    disabled
    LogScreenshot
    Should Not Be True    ${class15}


Deployment Report
    LogScreenshot
    Qwebelement.clicktext    Deployment reports
    ClickText    Download        Software Version
    ClickText    Download
    
    


Check the device is online in L1 and L2
    [Arguments]    ${dev}=${Root}[udefi_frn_name]    ${dec}=Yes
    Qwebelement.clicktext    Network
    Qwebelement.clicktext    ${dev}
    ${text2}=    GetText        ${connectivity_info_ondefault_staging}
    Log    ${text2}
    Run Keyword And Continue On Failure    Should Contain    ${text2}    Connection to cloudOnline
    LogScreenshot
    IF    '${dec}'=='Yes'
        Qwebelement.clicktext    Radio management
        Qwebelement.clicktext    ${dev}
        VerifyText    Online        30s
        LogScreenshot
    END

Verify corteca elements for readonly
    LogScreenshot
    Verifytext    Home troubleshooting
    VerifyText    Admin
    VerifyText    Analytics
    VerifyText    WiFi Optimization
    VerifyText    FCC Broadband Compliance


    
    
Analytics Dashboard check
    LogScreenshot
    VerifyText    Overview
    Qwebelement.clicktext    Overview
    VerifyText    Events and alarms
    ClickText    Events and alarms    Devices
    LogScreenshot
    VerifyText    Devices
    Qwebelement.clicktext    Devices
    LogScreenshot
    Verifytext    Performance report
    Qwebelement.clicktext    Performance report
    LogScreenshot
    Verifytext    Network device ranking
    Qwebelement.clicktext    Network device ranking
    LogScreenshot
    Verifytext    Network map
    Qwebelement.clicktext    Network map
    LogScreenshot


Wifi optmization check
    VerifyText    Power Configuration    30s
    Wifi Optimization Check For Readonly


wifi optimization check for readonly
    Verifytext    Profiles
    Verifytext    Groups
    Verifytext    Time zone
    LogScreenshot
    Qwebelement.clicktext    Area
    LogScreenshot
    VerifyNoText        Create new area profile
    Qwebelement.clicktext    Model
    LogScreenshot
    VerifyNoText        Create new model profile
    Qwebelement.clicktext    Groups
    Sleep    5s
    LogScreenshot
    VerifyNoText        Create new area group
    VerifyNoText        Upload .csv
    Qwebelement.clicktext    Model
    LogScreenshot
    VerifyNoText        Create new model group
