*** Settings ***
Library         QWeb
Library         ../../Resources/commonPythonKeywords/checktable.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Library         Collections
Variables       ../../Locators/AnalyticsWifipointLocators.py
Resource       ../../Resources/KeywordDefinition/AnalyticsRedirect.resource
*** Test Cases ***
NWCC_L1_NWCC_specificfeature_Analytics_wifipointranking_reboot
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to device ranking page
    Click Element     ${device_Ranking_page_link}
    Sleep    10s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  reboot
    Should Be Equal    ${res}    True
    Sleep   5s
    Click Element    ${calender_element}
    Click Element    ${seven_days_element}
    Click Element    ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow   reboot
    Should Be Equal    ${res}    True
    Click Element   ${calender_element}
    Click Element   ${thirty_days_element}
    Sleep   5s
    Click Element   ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow   reboot
    Should Be Equal    ${res}    True
    ${x}=  nextday
    Click Element     ${calender_element}
    Click Text    ${x}  anchor=date  timeout=20s
    Sleep   5s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  reboot
    Should Be Equal    ${res}    True
    Check_analytics_redirect

NWCC_L1_NWCC_specificfeature_Analytics_wifipointranking_coverage
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to device ranking page
    Click Element     ${device_Ranking_page_link}
    Sleep    10s
    Click Element     ${coverage_element}
    Log To Console    moving to coverage ranking
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  coverage
    Should Be Equal    ${res}    True
    Click Element     ${calender_element}
    Click Element    ${seven_days_element}
    Sleep   5s
    Click Element    ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  coverage
    Should Be Equal    ${res}    True
    Click Element   ${calender_element}
    Click Element   ${thirty_days_element}
    Sleep   5s
    Click Element   ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  coverage
    Should Be Equal    ${res}    True
    ${x}=  nextday
    Click Element     ${calender_element}
    Click Text    ${x}  anchor=date  timeout=20s
    Sleep   5s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  coverage
    Should Be Equal    ${res}    True
    Check_analytics_redirect

NWCC_L1_NWCC_specificfeature_Analytics_wifipointranking_cloud
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to device ranking page
    Click Element     ${device_Ranking_page_link}
    Sleep    10s
    Click Element     ${cloud_element}
    Log To Console    moving to cloud ranking
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  cloud
    Should Be Equal    ${res}    True
    Click Element     ${calender_element}
    Click Element    ${seven_days_element}
    Sleep   5s
    Click Element    ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  cloud
    Should Be Equal    ${res}    True
    Click Element   ${calender_element}
    Click Element   ${thirty_days_element}
    Sleep   5s
    Click Element   ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  cloud
    Should Be Equal    ${res}    True
    ${x}=  nextday
    Click Element     ${calender_element}
    Click Text    ${x}  anchor=date  timeout=20s
    Sleep   5s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  cloud
    Should Be Equal    ${res}    True
    Check_analytics_redirect


NWCC_L1_NWCC_specificfeature_Analytics_wifipointranking_congestion
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to device ranking page
    Click Element     ${device_Ranking_page_link}
    Sleep    10s
    Click Element     ${congestion_element}
    Log To Console    moving to congestion ranking
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  obss
    Should Be Equal    ${res}    True
    Click Element     ${calender_element}
    Click Element    ${seven_days_element}
    Sleep   5s
    Click Element    ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  obss
    Should Be Equal    ${res}    True
    Click Element   ${calender_element}
    Click Element   ${thirty_days_element}
    Sleep   5s
    Click Element   ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  obss
    Should Be Equal    ${res}    True
    ${x}=  nextday
    Click Element     ${calender_element}
    Click Text    ${x}  anchor=date  timeout=20s
    Sleep   5s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  obss
    Should Be Equal    ${res}    True
    Check_analytics_redirect

NWCC_L1_NWCC_specificfeature_Analytics_wifipointranking_noise
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to device ranking page
    Click Element     ${device_Ranking_page_link}
    Sleep    10s
    Click Element     ${noise_element}
    Log To Console    moving to noise ranking
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  noise
    Should Be Equal    ${res}    True
    Click Element     ${calender_element}
    Click Element    ${seven_days_element}
    Sleep   5s
    Click Element    ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  noise
    Should Be Equal    ${res}    True
    Click Element   ${calender_element}
    Click Element   ${thirty_days_element}
    Sleep   5s
    Click Element   ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  noise
    Should Be Equal    ${res}    True
    ${x}=  nextday
    Click Element     ${calender_element}
    Click Text    ${x}  anchor=date  timeout=20s
    Sleep   5s
    Click Element     ${download_csvButton}
    Sleep    10s
    ${res}=  checkcountrow  noise
    Should Be Equal    ${res}    True
    Check_analytics_redirect




