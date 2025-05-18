*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../Resources/TestSpecificProcedures/DataModelBrowserKeyword.resource
Resource        ../Resources/TestSpecificProcedures/LoginPageProcedures.robot

*** Test Cases ***
BBDT-247896_NWCC_Frontendgaps_USP_P9_05
    [Documentation]    Testcase Name: NWCC_Frontendgaps_USP_P9_05
    ...    Title: \ Data Browser page check
    ...    Objective:
    ...    1.Check for the available Wi-Fi points in the dropdown in the Data browser page
    ...    2.Check for the auto complete helper is shown
    ...    3.Check for the result for the data search are shown
    [Tags]    USP
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Check DataModelBrowserPage
    
BBDT-247897_NWCC_Frontendgaps_USP_P9_06
    [Documentation]    Testcase Name: NWCC_Frontendgaps_USP_P9_06
    ...    Title: \ Edit and save in browser page check
    ...    Objective:
    ...    1.Check for the edit option is working and will show the list of values can be edited in the pardiculata data model
    ...    2.Check after save the values are reflected in the data model and will not throw any issues while saving
    [Tags]    USP
    [Teardown]    Run Keywords    SetDefaultTimezone    AND    Logout From Corteca Console
    Login To Corteca Console
    Check Edit and Save option in Browser page
    
BBDT-248132_NWCC_AIOC_USP_HomeDashboard_05
    [Documentation]    Testcase Name: NWCC_AIOC_USP_HomeDashboard_05
    ...    Title: \ Verify Browser Tab fields in Settings page
    ...    Objective:
    ...    Check if the browser tab has the below fields
    ...    WiFi Point drop down menu
    ...    Data Model browser - Apply tab
    [Tags]    USP
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Move to DataModelBrowserPage
    Check defaultFields in DataModelBrowserPage

BBDT-248133_NWCC_AIOC_USP_HomeDashboard_06
    [Documentation]    Testcase Name: NWCC_AIOC_USP_HomeDashboard_06
    ...    Title: \ Verify GET Operations for Data Model in Browser page
    ...    Objective:
    ...    Check if the GET operation is proper w.r.t Data model fetch in browser page
    ...    1. Select the WiFi point from dropdown menu.
    ...    2. Enter the Data model value and click Apply.
    ...    3. Check if it lists all the entries w.r.t requested Data model.
    ...    4. Click on radio button to see the details of the fetched Data Model.
    ...    5. Check if Edit option is Masked or Enabled based on the permission granted.
    ...    6. GET Data Model output for both Root and EXT beacons in Mesh.
    ...    •EDIT and SET Data Models for specific params.
    ...    •EXT Beacons support only 3 Data Models.
    ...    ØDeviceInfo.
    ...    ØLocalAgent.
    ...    ØX_ALU-COM_Wifi. •Error notification is thrown if unsupported DM is given as input
    [Tags]    USP
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Move to DataModelBrowserPage
    Get operation check in Root
    Get operation check in Extenders
    Logout From Corteca Console
    Get operation check in ReadOnly Login

BBDT-248134_NWCC_AIOC_USP_HomeDashboard_07
    [Documentation]    Testcase Name: NWCC_AIOC_USP_HomeDashboard_07
    ...    Title: \ Verify SET Operations for Data Model in Browser page
    ...    Objective:
    ...    Check if the SET / EDIT operation is proper w.r.t Data model fetch in browser page
    ...    1. Select the WiFi point from dropdown menu
    ...    2. Enter the Data model value and click Apply.
    ...    3. Check if it lists all the entries w.r.t requested Data model.
    ...    4. Click on radio button to see the details of the fetched Data Model.
    ...    5. Click on the Edit option to make changes to the Params in that Data model.
    ...    6. Check in the CPE console if the changes are appended.
    ...    7. Check if the Success Notification is popped-up
    [Tags]    USP
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Move to DataModelBrowserPage
    Get operation check in Root
    Check entries are editable for DM    ${DataModelBrowserCheckCmd5}    ${DataModelEditableCheck}
    Check entries are editable for DM    ${DataModelBrowserCheckCmd6}    ${DataModelEditableCheck1}
    
