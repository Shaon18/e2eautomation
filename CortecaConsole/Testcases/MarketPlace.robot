*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/KeywordDefinition/Sshkeywords.resource
Resource    ../Resources/TestSpecificProcedures/ConfigureBoengSSH.resource
Resource    ../Resources/TestSpecificProcedures/MarketPlaceKeywords.resource
Variables    ../Resources/TestDatas.py

*** Test Cases ***
test
    ${appName}    Set Variable    ${MarketPlaceAndCampaignDictForTrial}[Application]
    ${appVersion}    Set Variable    ${MarketPlaceAndCampaignDictForOnline}[AppVersion]
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    ${rulename}    Set Variable    Rulefor_MarketPlace_Online
    ${textToCheck}    Set Variable    An online activation process for ${appName} has been successfully finished by ${MarketPlace}[tenant]
    ${maxAllowed}    Set Variable    ${MarketPlaceAndCampaignDictForOnline}[max_allowed]
    ${graphValue}    Get Rule Trend Graph    ${appName}    Rulefor_MarketPlace_Trail
    ${succesCountFromGraph}    Get Match From Graph    ${graphValue}    .*Successes.*\\n\\d+
    ${errorCountFromGraph}    Get Match From Graph    ${graphValue}    .*License Error.*Limit reached or permissions not granted.*\\n\\d+
    Should Be True    ${errorCountFromGraph}>=1

BBDT-276661 NWCC_L1_App_Marketplace_04
    [Documentation]    BBDT-276661 NWCC_L1_App_Marketplace_04 | Purchase request functionality based on Trial Subscriptions - Happy Flow
    ...    ${\n} To check the Purchase request functionality based on Trial Subscription: (Take any less likely used apps with TRIAL workflow for testing)
    ...    ${\n} 1: Steps:
    ...    ${\n}    1.From Central App database admin --> apps API configure apps workflow for an app version as trial.  "workflow": "trial" -> Here selected Nokia Fsecure
    ...    ${\n}    2.From Central App database admin --> tenant API configure the max_installation to 2. 
    ...    ${\n}                      "scope": "View",
    ...    ${\n}                      "max_installation": 2,
    ...    ${\n}                      "uuid": "fb882f7e-b50b-526b-8f4a-5c0be5039ed0"
    ...    ${\n} 3. Go to Marketplace dashboard and click Fsecure Sense and click ""GET"" on the particular app and clicking GET on a particular application, it will send API to Central app database and based on the workflow defined as "TRIAL" , FE shows ""Accept the Terms & Conditions"" to agree upon
    ...    ${\n} 4. Click Agree in the FE for T&C and in the API it changes to below:
    ...    ${\n}            {
    ...    ${\n}            "updated_at": "2024-03-21T17:21:39.311Z",
    ...    ${\n}            "scope": "Install",
    ...    ${\n}            "max_installation": 2,
    ...    ${\n}            "current_state": "TRIAL",
    ...    ${\n}            "current_status": "COMPLETED",
    ...    ${\n}            "created_at": "2024-03-21T17:21:10.351Z",
    ...    ${\n}            "uuid": "fb882f7e-b50b-526b-8f4a-5c0be5039ed0"
    ...    ${\n}           },
    ...    ${\n} 
    ...    ${\n} 6.Make sure email has been received as per the email address provided in the API ->  An online activation process for <Nokia Fingerprint> has been successfully finished by nokiahwstg
    ...    ${\n} In the marketplace FE, the app status is set to "Trial" and corresponding application will be given the INSTALL permission to install the app from campaign scheduler intent.
    ...    ${\n} 7.Check the CSP/Purchase team can able to create Scheduler Install rule for more than 3 devices with 1 hour duration and check the installation gets successful only for 2 devices.
    ...    ${\n} 8.Once above scenarios are completed when the scheduler timer hits:
    ...    ${\n}     1.Check for any 2 devices in that particular model (or via csv)the application is installed and running.
    ...    ${\n}     2.From the 2 particular subscribers page check the app is installed properly under the "Installed applications" section.
    ...    ${\n}     3.History events are updated properly in applications page with Time/appname/event name
    ...    ${\n}     4.App deployment report has the corresponding entry for the 2 devices alone
    ...    ${\n}     5.Trends chart is incremented with the install count for the 2 successful devices & 1 entry for license count exceeded even upon multiple retries
    ...    ${\n}     6.Download the Trends report and check the corresponding action is updated properly
    ...    ${\n}                 STATUS - COMPLETED for only 2 devices , for the 3rd device status will be "limit exceeded"
    ...    ${\n}     7.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...    ${\n}     8."Enabled license" under campaign gets incremented by only 2 based on the number of installations
    ...    ${\n}     Check for the Installation count gets incremented at the CAD based on the number of installations/activations".
    ...    ${\n} 9. Login to the particular subscriber and try to install the Fsecure application manually and it should get failed there as well.
    ...    ${\n} 10.Uninstall the Fsecure app from the Applications page and ensure the entry gets removed from App deployment report and "Enabled license" gets decremented by 1.
    ...    ${\n} 11.Using Applications page or via campaign manager, install the container app for the 3rd device which gets failed earlier and now Install should gets succeeded. Ensure:
    ...    ${\n} the app entry gets added to the App deployment report and "Enabled license" gets incremented by 1.
#    [Teardown]    Marketplace Teardown    ${appName}    ${rulename}    ${appVersion}    ${MarketPlaceAndCampaignDictForTrial}[HwMacs]
    ${csvFilePath}    Create CSV File    csvForTrial
    Append to CSV    ${csvFilePath}    MAC
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForTrial}[HwMacs]
        Append to CSV    ${csvFilePath}    \n${mac}
    END
    ${action}    Set Variable    Install
    ${appName}    Set Variable    ${MarketPlaceAndCampaignDictForTrial}[Application]
    ${appVersion}    Set Variable    ${MarketPlaceAndCampaignDictForTrial}[AppVersion]
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    ${rulename}    Set Variable    Rulefor_MarketPlace_Trail
    ${textToCheck}    Set Variable    An online activation process for ${appName} has been successfully finished by ${MarketPlace}[tenant]

    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForTrial}[HwMacs]
        Run Keyword And Continue On Failure    Uninstall The Application And History Validation    ${appName}    ${appVersion}    ${mac}
    END
    Run Keyword And Ignore Error    Run Keyword And Continue On Failure    Delete App Rule    ${appName}    ${rulename}

    ${existingInstallCount}    Get Enabled License Count for App    ${appName}
    ${maxAlowed}    Evaluate    ${existingInstallCount}+1

    Log To Console    **** 2.From Central App database admin --> tenant API configure the max_installation to 2. ****
    Put New Tenant Json    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForTrial}[appUuid]    ${MarketPlaceAndCampaignDictForTrial}[key]    ${MarketPlaceAndCampaignDictForTrial}[scope]    ${maxAlowed}
    Log To Console    **** 3. Go to Marketplace dashboard and click Fsecure Sense and click ""GET"" on the particular app and clicking GET on a particular application, it will send API to Central app database and based on the workflow defined as "TRIAL" , FE shows ""Accept the Terms & Conditions"" to agree upon ****
    Purchase App From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForTrial}[workflow]    ${MarketPlaceAndCampaignDictForTrial}[scope]    ${rulename}    ${csvFilePath}
    Log To Console    **** 4. Click Agree in the FE for T&C and in the API it changes ****
    Validate TenantInfo After Purchase    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForTrial}[appUuid]    ${action}    ${maxAlowed}    TRIAL    COMPLETED
    Log To Console    **** 5. Make sure email has been received as per the email address provided in the API ****
    Email Validation    ${MarketPlace}[gmailId]    ${MarketPlace}[password]    ${textToCheck}    ${MarketPlace}[tenant]    ${MarketPlace}[uname]    ${appName}    ${MarketPlaceAndCampaignDictForTrial}[appUuid]
    Log To Console    **** 6. In the marketplace FE, the app status is set to "Trial" ****
    App Status From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForTrial}[workflow]    ${action}    Trial

    Log To Console    **** 7. Corresponding application will be given the INSTALL permission to install the app from campaign scheduler intent ****
    Run Keyword And Continue On Failure    Validate App Installation Trial    ${appName}    ${rulename}    ${maxAlowed}    ${MarketPlaceAndCampaignDictForTrial}
    Log Many    ${SuccessMacsList}    ${ErrorMacsList}
    Log To Console    **** Disabling Rule before validating the failed MAC installation
    Run Keyword And Continue On Failure    EnableDisable The Campaign Rule    ${appName}    ${rulename}    False
    Run Keyword And Continue On Failure    Validate App Installation For Failed Macs    ${SuccessMacsList}    ${ErrorMacsList}    ${appName}    ${appVersion}    ${maxAlowed}

BBDT-276662 NWCC_L1_App_Marketplace_05
    [Documentation]    BBDT-276662 NWCC_L1_App_Marketplace_05|Purchase request functionality based on Online Subscriptions - Happy Flow
    ...    ${\n} To check the Purchase request functionality based on Online Subscription
    ...    ${\n} 1: Steps:
    ...    ${\n}    1..From Central App database admin --> apps API configure apps workflow as online (attached api)  "workflow": "online" -> Here selected FingerPrint
    ...    ${\n}    2.From Central App database admin --> tenant API configure the max_installation to -1. (Attached the consolidated payload)
    ...    ${\n}                      "scope": "View",
    ...    ${\n}                      "max_installation": -1,
    ...    ${\n}                      "uuid": "fb882f7e-b50b-526b-8f4a-5c0be5039ed0"
    ...    ${\n} 3. Go to Marketplace dashboard and click any app and click ""GET"" on the particular app and clicking GET on a particular application, it will send API to Central app database and based on the workflow defined and FE shows ""Accept the Terms & Conditions"" to agree upon and on success, corresponding application will be given the INSTALL permission to install the app from campaign scheduler intent and App redirects directly to the Campaign manager.
    ...    ${\n} 4. In the marketplace FE, the app status is set to Activated and make sure email has been received as per the email address provided in the API
    ...    ${\n}             An online activation process for <Nokia Fingerprint> has been successfully finished by nokiahwstg
    ...    ${\n} 5. Check int he CAD admin --> tenant api --> GET , the status got changed as below:
    ...    ${\n}             "scope": "Install",
    ...    ${\n}            "max_installation": -1,
    ...    ${\n}             "current_state": "PURCHASE_COMPLETED",
    ...    ${\n}            "current_status": "COMPLETED",
    ...    ${\n}             "created_at": "2024-03-21T17:12:44.786Z",
    ...    ${\n}            "uuid": "395c2ecc-2da8-5c67-a807-8b70f0e55511"
    ...    ${\n}           },
    ...    ${\n}
    ...    ${\n} 6.Check the CSP/Purchase team can be able to do the corresponding app installations for many devices.
    ...    ${\n} 7. .Create a scheduler rule (Steps same as Test case BBDT-255203 Scenario 1)
    ...    ${\n}        1.Install a container app by selecting a hardware model without firmware version selected.
    ...    ${\n}        2.Select the application version to install
    ...    ${\n}        3.Select the Scheduler option & Apply on Boot toggle
    ...    ${\n}        4.Enter the scheduler time/Duration & Timezone
    ...    ${\n}        5.Save the scheduler rule
    ...    ${\n} Once above scenarios are completed when the timer hits:
    ...    ${\n} 1.Check for all the devices in that particular model the application is installed and running.
    ...    ${\n} 2.From the particular subscribers page check the app is installed properly under the "Installed applications" section.
    ...    ${\n} 3.History events are updated properly in applications page with Time/appname/event name
    ...    ${\n} 4.App deployment report has the corresponding entry
    ...    ${\n} 5.Trends chart is incremented with the install count for the success
    ...    ${\n} 6.Download the Trends report and check the corresponding action is updated properly
    ...    ${\n} 7.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...    ${\n} 8."Enabled license" under campaign gets incremented based on the number of installations
#    [Teardown]    Marketplace Teardown    ${appName}    ${rulename}    ${appVersion}    ${MarketPlaceAndCampaignDictForOnline}[HwMacs]
    ${csvFilePath}    Create CSV File    csvForOnline
    Append to CSV    ${csvFilePath}    MAC
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForOnline}[HwMacs]
        Append to CSV    ${csvFilePath}    \n${mac}
    END
    ${action}    Set Variable    Install
    ${appName}    Set Variable    ${MarketPlaceAndCampaignDictForOnline}[Application]
    ${appVersion}    Set Variable    ${MarketPlaceAndCampaignDictForOnline}[AppVersion]
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    ${rulename}    Set Variable    Rulefor_MarketPlace_Online
    ${textToCheck}    Set Variable    An online activation process for ${appName} has been successfully finished by ${MarketPlace}[tenant]
    ${maxAllowed}    Set Variable    ${MarketPlaceAndCampaignDictForOnline}[max_allowed]

    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    Run Keyword And Ignore Error    Run Keyword And Continue On Failure    Delete App Rule    ${appName}    ${rulename}
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForOnline}[HwMacs]
        Run Keyword And Continue On Failure    Uninstall The Application And History Validation    ${appName}    ${appVersion}    ${mac}
    END

    Log To Console    **** 2.From Central App database admin --> tenant API configure the max_installation to -1. ****
    Put New Tenant Json    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForOnline}[appUuid]    ${MarketPlaceAndCampaignDictForOnline}[key]    ${MarketPlaceAndCampaignDictForOnline}[scope]    ${maxAllowed}
    Log To Console    **** 3. When the CSP/Purchase team want to get any container apps,  click ""GET"" on the particular app  and it shows a toaster message to to "contact sales ****
    Purchase App From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForOnline}[workflow]    ${MarketPlaceAndCampaignDictForOnline}[scope]    ${rulename}    ${csvFilePath}    MarketPlaceAndCampaignAppDict=${MarketPlaceAndCampaignDictForOnline}

    Log To Console    **** 5.a Validate API After purchase ****
    Validate TenantInfo After Purchase    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForOnline}[appUuid]    ${action}    ${maxAllowed}    PURCHASE_COMPLETED    COMPLETED
    Log To Console    **** 5.b Make sure email has been received as per the email address provided in the API ****
    Email Validation    ${MarketPlace}[gmailId]    ${MarketPlace}[password]    ${textToCheck}    ${MarketPlace}[tenant]    ${MarketPlace}[uname]    ${appName}    ${MarketPlaceAndCampaignDictForOnline}[appUuid]    emailSubject=${emailSubjectOnline}
    Log To Console    **** 6. In the marketplace FE, the app status is set to "Activated" ****
    App Status From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForOnline}[workflow]    ${action}    Activated

    Log To Console    **** Validate Campaign Rule ****
    Validate App Installation For Online Offline Workflow    ${appName}    ${rulename}    ${MarketPlaceAndCampaignDictForOnline}


BBDT-276663 NWCC_L1_App_Marketplace_06
    [Documentation]    BBDT-276663 NWCC_L1_App_Marketplace_06|Purchase request functionality based on Offline Subscription - Happy Flow
    ...    ${\n} To check the Purchase request functionality based on Offline Subscription:
    ...    ${\n} 1: Steps:
    ...    ${\n} 1.From Central App database admin --> apps API configure apps workflow as offline (attached api) -> Here selected OpenVPNClient
    ...    ${\n} 2.From Central App database admin --> tenant API configure the max_installation to -1. (Attached the consolidated payload)
    ...    ${\n}                      "scope": "View",
    ...    ${\n}                      "max_installation": -1,
    ...    ${\n}                      "uuid": "fb882f7e-b50b-526b-8f4a-5c0be5039ed0"
    ...    ${\n} 3. When the CSP/Purchase team want to get any container apps,  click ""GET"" on the particular app  and it shows a toaster message to to "contact sales" and the API changed as below:
    ...    ${\n}             "updated_at": "2024-03-19T10:36:58.387Z",
    ...    ${\n}             "scope": "View",
    ...    ${\n}             "max_installation": -1,
    ...    ${\n}             "current_state": "WAIT_FOR_INTEREST",
    ...    ${\n}             "current_status": "COMPLETED",
    ...    ${\n}             "created_at": "2024-03-15T12:27:51.767Z",
    ...    ${\n}             "uuid": "d50ffa52-3a20-5887-ab58-8f33b6fe4d62"
    ...    ${\n} 4.Clicking contact sales changes the API to below state and the app will be in PENDING status:
    ...    ${\n}             "updated_at": "2024-07-15T12:02:44.561Z",
    ...    ${\n}             "scope": "View",
    ...    ${\n}             "max_installation": -1,
    ...    ${\n}             "current_state": "PURCHASE_PENDING",
    ...    ${\n}             "current_status": "COMPLETED",
    ...    ${\n}             "created_at": "2024-03-15T12:27:52.767Z",
    ...    ${\n}             "uuid": "d50ffa52-3a20-5887-ab58-8f33b6fe4d62"
    ...    ${\n}
    ...    ${\n} 5. An email will be triggered in parallel for the admin to update the api as below:
    ...    ${\n}            "updated_at": "2024-03-19T10:36:58.387Z",
    ...    ${\n}            "scope": "Install",
    ...    ${\n}            "max_installation": -1,
    ...    ${\n}            "current_state": "PURCHASE_COMPLETED",
    ...    ${\n}            "current_status": "COMPLETED",
    ...    ${\n}            "created_at": "2024-03-15T12:27:51.767Z",
    ...    ${\n}            "uuid": "d50ffa52-3a20-5887-ab58-8f33b6fe4d62"
    ...    ${\n}
    ...    ${\n} 6.Check the CSP/Purchase team can be able to do the corresponding app installations for many devices.
    ...    ${\n} 7. Create a scheduler rule (Steps same as Test case BBDT-255203 Scenario 2)
    ...    ${\n} Scenario 2: Install -- Based on hardware model with specific Firmware selection & Rule triggered during "Apply on Boot"
    ...    ${\n}    1.Install a container app by selecting a hardware model with a specific firmware version selected.
    ...    ${\n}    2.Select the application version to install
    ...    ${\n}    3.Select the Scheduler option & Apply on Boot toggle
    ...    ${\n}    4.Enter the scheduler time/Duration & Timezone
    ...    ${\n}    5.Save the scheduler rule
    ...    ${\n}    6.Reboot the device (or) schedule firmware upgrade before the application schedule time hits.
    ...    ${\n} Check after receiving the "BOOT" event,
    ...    ${\n}    1.For all the devices in that particular model the application is installed and running.
    ...    ${\n}    2.From the particular subscribers page check the app is installed properly under the "Installed applications" section.
    ...    ${\n}    3.History events are updated properly in applications page with Time/appname/event name
    ...    ${\n}    4.App deployment report has the corresponding entry
    ...    ${\n}    5.Trends chart is incremented with the install count for the success
    ...    ${\n}    6.Download the Trends report and check the corresponding action is updated properly
    ...    ${\n}    7.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...    ${\n}    8."Enabled license" under campaign gets incremented based on the number of installations
#    [Teardown]    Marketplace Teardown    ${appName}    ${rulename}    ${appVersion}    ${MarketPlaceAndCampaignDictForOffline}[HwMacs]
    ${csvFilePath}    Create CSV File    csvForOffline
    Append to CSV    ${csvFilePath}    MAC
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForOffline}[HwMacs]
        Append to CSV    ${csvFilePath}    \n${mac}
    END
    ${action}    Set Variable    Install
    ${appName}    Set Variable    ${MarketPlaceAndCampaignDictForOffline}[Application]
    ${appVersion}    Set Variable    ${MarketPlaceAndCampaignDictForOffline}[AppVersion]
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    ${rulename}    Set Variable    Rulefor_MarketPlace_Offline
    ${textToCheck}    Set Variable    An Approval process for ${appName} has been initiated by ${MarketPlace}[tenant].
    ${maxAllowed}    Set Variable    ${MarketPlaceAndCampaignDictForOffline}[max_allowed]

    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    Run Keyword And Ignore Error    Run Keyword And Continue On Failure    Delete App Rule    ${appName}    ${rulename}
    FOR    ${mac}    IN    @{MarketPlaceAndCampaignDictForOffline}[HwMacs]
        Run Keyword And Continue On Failure    Uninstall The Application And History Validation    ${appName}    ${appVersion}    ${mac}
    END

    Log To Console    **** 2.From Central App database admin --> tenant API configure the max_installation to -1. ****
    Put New Tenant Json    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForOffline}[appUuid]    ${MarketPlaceAndCampaignDictForOffline}[key]    ${MarketPlaceAndCampaignDictForOffline}[scope]    ${maxAllowed}
    Log To Console    **** 3. When the CSP/Purchase team want to get any container apps,  click ""GET"" on the particular app  and it shows a toaster message to to "contact sales ****
    Purchase App From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForOffline}[workflow]    ${MarketPlaceAndCampaignDictForOffline}[scope]    ${rulename}    ${csvFilePath}
    Log To Console    **** 5. Updating The API for completing the purchase ****
    Complete Purchase For Apps    ${appName}    ${MarketPlace}    ${MarketPlaceAndCampaignDictForOffline}

    Log To Console    **** 5.a Validate API After purchase ****
    Validate TenantInfo After Purchase    ${MarketPlace}[tenant]    ${MarketPlaceAndCampaignDictForOffline}[appUuid]    ${action}    ${maxAllowed}    PURCHASE_COMPLETED    COMPLETED
    Log To Console    **** 5.b Make sure email has been received as per the email address provided in the API ****
    Email Validation    ${MarketPlace}[gmailId]    ${MarketPlace}[password]    ${textToCheck}    ${MarketPlace}[tenant]    ${MarketPlace}[uname]    ${appName}    ${MarketPlaceAndCampaignDictForOffline}[appUuid]    emailSubject=${emailSubjectOffline}
    Log To Console    **** 6. In the marketplace FE, the app status is set to "Activated" ****
    App Status From Market Place    ${appName}    ${MarketPlaceAndCampaignDictForOffline}[workflow]    ${action}    Activated

    Log To Console    **** Creating Campaign Schedule ****
    Create Application Rule    ${rulename}    ${action}    ${MarketPlaceAndCampaignDictForOffline}[HwModel]    ${MarketPlaceAndCampaignDictForOffline}[FirmwareVersions]    ${appVersion}    ${csvFilePath}    ${MarketPlaceAndCampaignDictForRule}    application=${appName}

    Log To Console    **** Validate Campaign Rule ****
    Validate App Installation For Online Offline Workflow    ${appName}    ${rulename}    ${MarketPlaceAndCampaignDictForOffline}
