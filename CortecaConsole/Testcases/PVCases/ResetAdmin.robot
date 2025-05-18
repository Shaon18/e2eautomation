*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/NEWPV/resetadmin.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource



*** Test Cases ***

BBDT-176386 NWCC_AIOC_TroubleshootingDashboard_14 | Verify Reset Admin Password
    [Documentation]    1.) login check with default admin password
     ...                2.) set the password with cfgcli cmd
     ...                3.) login check with set password
     ...                4.) reset the password
     ...                5>) check the login
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Log    change the admin password to default
    ${res}   SSHExecute    ${changeadminpass}${Root}[gui_Normal_User_pwd]
    Run Keyword And Continue On Failure    Should Contain        ${res}    success
    Log    sign in to webgui using original password
    Open Pureview WebGui     username=${Root}[gui_Normal_User]    paswd=${Root}[gui_Normal_User_pwd]
    Log    change the admin password
    ${result}   SSHExecute    ${changeadminpass}${modified_pass}
    Run Keyword And Continue On Failure    Should Contain    ${result}    success
    Log     try signing to webgui using original password and it will fail
    ${result2}    Run Keyword And Return Status    Open Pureview WebGui    username=${Root}[gui_Normal_User]    paswd=${Root}[gui_Normal_User_pwd]
    Should Not Be True    ${result2}
    Log   try signing in to webgui using changed password and it will work
    Open Pureview WebGui    username=${Root}[gui_Normal_User]    paswd=${modified_pass}
    Log    Trigger reset admin via corteca console
    Trigger Reset Admin
    Log     try signing to webgui using modified password and it will fail
    ${result3}    Run Keyword And Return Status    Open Pureview WebGui       username=${Root}[gui_Normal_User]   paswd=${modified_pass}
    Should Not Be True    ${result3}
    Log    sign in to webgui using original password and it will work
    Open Pureview WebGui    username=${Root}[gui_Normal_User]    paswd=${Root}[gui_Normal_User_pwd]


