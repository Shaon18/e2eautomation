*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         ../../InputFiles/imagecomparision.py
Resource        ../../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables        ../../Locators/CortecaConsoleLocators.py


*** Keywords ***

topology backhaul
    ${datenow}    DateTime.Get Current Date    result_format=%d.%m.%Y-%H.%M
    Run Keyword and Ignore Error    Execute javascript    document.body.style.zoom="100%"
    Wait Until Page Contains Element    ${repeatdiagnostic}    timeout=300s
    Sleep  5s
    Capture Element Screenshot   ${topology_backhaul}    ${topologyscpath}/topologycompare${datenow}.png
    ${ssim}    Calculate Image Similarity      ${supporting_path}/topology.png      ${topologyscpath}/topologycompare${datenow}.png
    Log    ${ssim}
    Run Keyword If    ${ssim}<0.9        Fail
