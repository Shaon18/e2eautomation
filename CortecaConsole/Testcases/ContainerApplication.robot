*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/ContainerAppKeyword.resource
Variables    ../Resources/TestDatas.py
Library    Collections

*** Test Cases ***

BBDT-221519_NWCC_L1_ContainerMgmt_05
    [Documentation]    NWCC_L1_ContainerMgmt_05|Verify Home console show "Applications" Section in Home Console - Existing Subscriber with apps installed & activated
    ...    *Script covered only Login with Admin*
    ...            "To check Home console show ""Applications"" Section in Home Console based on:
    ...                1.Device capability [misc_feature = usp_container_mgmt]
    ...                2.USP MESH
    ...                3.User role - Admin or Care Agent
    ...            And on clicking the Applications menu it will redirect to another screen which will show:
    ...    Scenario 1: Logged in as ""admin""
    ...    Title: Available     ...    Applications
    ...    <Listing all the available/compatible applications for the Root device with Name/logo/description/category/version> based on the metadata info
    ...    <Install button will be shown>
    ...
    ...    Title: Installed Applications
    ...    It will display the containers which are installed on the CPE \ with below information
    ...    Name
    ...    Version
    ...    Execution Unit status: Running or Idle
    ...    AutoStart status: Enabled or disabled
    ...    Remove [Uninstall]
    ...    In L1 FE, when user stays in the same page, shall refresh this container list for every XX seconds
    ...    (configurable via env, default can be 60 seconds)
    ...
    ...    Title: Event History
    ...    Default template will be available with below info
    ...    Date
    ...    Application
    ...    Description
    [Tags]    USP    Fsecure
    [Teardown]    Uninstall The Application And History Validation    ${containerFsecure}    ${FsecureInstallVersionCurrent}
    Log    **** 1: Validate Router ManifestKey before fsecure install
    Validate Router ManifestKey    initial=${True}
    Log    **** 1: Install the fingerprinting app
    Install Container Application    ${containerFsecure}    ${FsecureInstallVersionCurrent}    initalInstall=${True}
    ${systemTime}    Get Device Time In Epoch
    Log    **** 2: Installed Application card validation
    Validate Installed Application From Portal    ${containerFsecure}    ${FsecureInstallVersionCurrent}    ${True}    ${True}
    Log    **** 3: Installed Application History validation
    App Install Events Validation    ${FsecureInstallVersionCurrent}    ${containerStatusEnable}    ${containerAutostartEnable}    ${systemTime}    ${containerFsecure}
    Log    **** 1: Validate Router ManifestKey after fsecure install
    Run Keyword And Continue On Failure    Validate Router ManifestKey
    Cli Check After App Install    Sense    ${FPInstallVersionCurrent}    true    Active    Active
    Process Running Check    ps -w | grep sense    sense

BBDT-233404_NWCC_ContainerApp_Fingerprinting_03
    [Documentation]    Verify Fingerprinting Container App Installation in CPE
    ...    Check if the Fingerprinting Container Application loads properly in the CPE for the below,
    ...    HA Strategy - use HDM to push the FP Container App to CPE
    ...    USP Strategy - use AIOC Portal Applications Page in Home Dashboard to push the FP Container App to CPE.
    ...    Note: ******
    ...        This script covers only USP part and container life cycle management
    [Tags]    USP    FP
    [Teardown]    Uninstall The Application And History Validation    ${containerFingerPrint}    ${FPInstallVersionCurrent}
    Log    **** 1: Install the fingerprinting app
    Install Container Application    ${containerFingerPrint}    ${FPInstallVersionCurrent}
    ${systemTime}    Get Device Time In Epoch
    Log  #  **** 2: Installed Application card validation
    Validate Installed Application From Portal    ${containerFingerPrint}    ${FPInstallVersionCurrent}    ${True}    ${True}
    Log    **** 3: Installed Application History validation
    App Install Events Validation    ${FPInstallVersionCurrent}    ${containerStatusEnable}    ${containerAutostartEnable}    ${systemTime}    ${containerFingerPrint}
    Run Keyword And Continue On Failure    Cli Check After App Install    nokia_fingerprint    ${FPInstallVersionCurrent}    true    Active    Active
