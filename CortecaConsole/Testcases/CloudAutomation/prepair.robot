*** Settings ***
Library         QWeb
Library         String
Library         Collections
Library         ../../Resources/mobileautomation/uiautomatorrobot.py
Resource        ../../Resources/KeywordDefinition/adminpagekeywords.robot
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../InputFiles/sampleSetupFileFormat.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py


*** Test Cases ***
prepair_1
    ${mobile}=    Set Variable    PDAID19052600537    
    connect_mobile    ${mobile}


