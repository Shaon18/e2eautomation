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

Verify corteca elements for fullaccess
    Verifytext    Home troubleshooting
    VerifyText    Admin
    VerifyText    Analytics
    VerifyText    WiFi Optimization
    VerifyText    FCC Broadband Compliance
    VerifyText   Network Monitoring
    VerifyText    Marketplace



check admin page options for fullaccess
    VerifyText    Provisioning    15s
    VerifyText    CustomerID association    15s
    VerifyText    Deployment reports    15s
    VerifyText    Campaigns
    LogScreenshot
    
    
Campaign Check
    Qwebelement.clicktext    Campaigns
    LogScreenshot
    VerifyText    Applications
    VerifyText    Firmware versions
    VerifyText    Configuration files
    VerifyText    Reboots
    Qwebelement.clicktext    Applications
    LogScreenshot
    VerifyText    Campaigns / Applications    50s
    VerifyAny    ${applications}
    Qwebelement.clicktext    Firmware versions
    LogScreenshot
    VerifyText    Available firmware versions
    VerifyNoText    No data available
    Qwebelement.clicktext    Configuration files
    LogScreenshot
    VerifyText    Available configuration files
    VerifyNoText    No data available
    Qwebelement.clicktext    Reboots
    LogScreenshot
    VerifyText    Configured reboot rules
    VerifyText    Name
    VerifyText    Model
    VerifyText    Frequency
    VerifyText    Status
    VerifyNoText    No data available

network monitoring
   SwitchWindow    NEW
   Grafana Check


grafana check
    Sleep    10s
    LogScreenshot
    VerifyText    Home
    VerifyText    Bookmarks
    VerifyText    Starred
    VerifyText    Dashboards
#    VerifyText    Explore
    VerifyText    Alerting
    VerifyText    Network Monitoring – Corteca Home Controller
    VerifyText    Built-in dashboards
    VerifyText    	Overview
    VerifyText    Channel Management
    VerifyText    Steers
    VerifyText    Wi-Fi Performance
    VerifyText    Devices
    VerifyText    Cloud Connectivity
    VerifyText    	Quality Indicators



Wifi optmization check for fullaccess
    LogScreenshot
    Verifytext    Profiles
    Verifytext    Groups
    VerifyText    Power Configuration    30s
    Verifytext    Time zone
    Qwebelement.clicktext    Area
    LogScreenshot
    VerifyText        Create new area profile
    Qwebelement.clicktext    Model
    LogScreenshot
    VerifyText        Create new model profile
    Qwebelement.clicktext    Groups
    Sleep    5s
    LogScreenshot
    VerifyText        Create new area group
    VerifyText        Upload .csv
    Qwebelement.clicktext    Model
    LogScreenshot
    VerifyText        Create new model group


marketplace check
    Qwebelement.clicktext    Marketplace
    LogScreenshot
    Sleep  5s
    ${url}=    GetUrl
    Should Contain        ${url}    app-marketplace
