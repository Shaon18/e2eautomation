*** Settings ***
Library         String
Library         Collections
Library         RequestsLibrary
Library         DateTime
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource        ../../Resources/TestSpecificProcedures/DeviceDetails.resource

*** Test Cases ***
BBDT-162611_BBDT-162614_BBDT-162615_BBBDT-162617_NWCC_AIOC_HomeDashboard_DeviceDetails
    [Documentation]    Verify Device Details page info
    ...    "Check if the Device Details page has the below Tabs with relevant info
    ...    Device Information, Connectivity Information, Status(Coverage, Stability, Connectivity), Signal Level Graph
    Log   ****Check and validate Devices tab***
    Move To Home Dashboard
    Verify Devices page
    Verify Connected/Not connected Device Tab
    Verify Each Devices Info Page
