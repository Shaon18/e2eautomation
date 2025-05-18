*** Settings ***
Library         String
Library         Collections
Library         QWeb
Library         Process
Library         DateTime
Library         RequestsLibrary
Variables       ../../Locators/CortecaConsoleLocators.py
Variables       ../../InputFiles/EnvironmentInput.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/NEWPV/privacydata.resource




*** Test Cases ***

NWCC_L1BE_USP_Phase7_Privacy_03 | Set privacy data enable to false via API

    [Documentation]    NWCC_L1BE_USP_Phase7_Privacy_03 | Set privacy data enable to false via API
    [Tags]    USP
    [Teardown]    Qw.closebrowser
    Set Data False




NWCC_L1BE_USP_Phase7_Privacy_06| Set privacy data enable with true when it is false

    [Documentation]    NWCC_L1BE_USP_Phase7_Privacy_06| Set privacy data enable with true when it is false
    [Tags]    USP
    [Teardown]    Qw.closebrowser
    Set Data True When False

    


BBDT-31279|NWCC_L1_Privacydata_04 | Privacy data collection - false and true
    [Documentation]   Action:Do privacy settings disable/enable and check whether all process gets started and both home and network console live updates are seen
    [Tags]    both
    [Teardown]    Qw.closebrowser
    ${re}    Get Privacy Data Value
    IF    '${re}'=='True'
        Log    When privacy data is enabled, disabling and checking it
        Support Session Enabled    True
        Put Privacy Data Value    false
        Support Session Enabled    False
        Log    Resetiing the values to enabled
        Put Privacy Data Value    true
        Support Session Enabled    True
    ELSE
        Log     when privacy data is disabled, enabling and checking it
        Support Session Enabled    False
        Put Privacy Data Value    true
        Support Session Enabled    True
    END





