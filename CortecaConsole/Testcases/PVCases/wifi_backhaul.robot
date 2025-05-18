*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         ../../InputFiles/imagecomparision.py
Resource        ../../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource        ../../Resources/TestSpecificProcedures/wifi_backhaul.resource
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py




*** Test Cases ***

BBDT-162618|NWCC_AIOC_HomeDashboard_20|Verify Network topology in wifi backhaul
    [Documentation]    Verify Network topology in wifi backhaul
    ...                Capture Element Screenshot    of the topology page
    ...                check it with the already available image of the topology page
    [Tags]    Both    smoke   pvcase
    [Teardown]    Close All Browsers
    Login To Corteca Console
    Open Corteca Console Home Page
    Topology Backhaul



