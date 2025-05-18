*** Settings ***
Library     String
Library     Collections
Library     QWeb
Library     Process
Library        DateTime
Variables       ../../InputFiles/sampleSetupFileFormat.py
Variables           ../../Locators/CortecaConsoleLocators.py
Variables           ../../Locators/keycloak.py
Variables       ../../InputFiles/EnvironmentInput.py
Resource       Qtwebkeywords.resource



*** Keywords ***

Move to page
    [Arguments]    ${cd}
    ClickElement    xpath=(//button[contains(@color,'primary')])[1]
    Qwebelement.clicktext    ${cd}



Login to QWEB browser for keycloak
    [Arguments]    ${pc}    ${tenant}=nokiahwstg
    LoginTobrowserqweb    ${masteruser}[URL]/${tenant}    chrome    ${pc}[username]    ${pc}[password]
    
    
    
