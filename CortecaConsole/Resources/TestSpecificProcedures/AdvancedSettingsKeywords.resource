*** Settings ***
Library    Selenium
Library    String
Library    Telnet
Library    Process
Library    Collections
Library    JSONLibrary
Library    DateTime
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource    LoginPageProcedures.robot
Variables    ../../Resources/TestDatas.py
Resource    ../Resources/TestSpecificProcedures/ContainerAppKeyword.resource

*** Keywords ***
