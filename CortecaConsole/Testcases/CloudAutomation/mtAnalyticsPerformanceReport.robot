*** Settings ***
Library         QWeb
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Library         Collections
Variables       ../../Locators/AnalyticsPerformanceReport.py
Library         ../../Resources/commonPythonKeywords/checktable.py
Library         ../../Resources/commonPythonKeywords/performance_report.py
*** Test Cases ***
NWCC_L1_NWCC_specificfeature_Analytics_performancereport_default
#downloads perdormance report of all mac's in the default setting page
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_noise
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_noise_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    Sleep    5s
    ${res}=  performance_report   noise
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    Sleep    5s
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    Sleep    5s
    ${res}=  performance_report   noise
    Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_cloud
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_cloud_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    Sleep    5s
    ${res}=  performance_report  cloud_disconnections
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  cloud_disconnections
    Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_reboot
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_reboot_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  reboot
    Should Be Equal    ${res}    True
    Log To Console    1 day passed
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  reboot
    Should Be Equal    ${res}    True
    Log To Console    30 days passed

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_claim
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_claim_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  claim
    Should Be Equal    ${res}    True
    Log To Console    1 day passed
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  claim
    Should Be Equal    ${res}    True
    Log To Console    30 days passed

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_newWiFi
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_newWiFi_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  newWiFi
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  newWiFi
    Should Be Equal    ${res}    True


NWCC_L1_NWCC_specificfeature_Analytics_performancereport_coverage
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_coverage_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  coverage
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  coverage
    Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_congestion
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_congestion_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
    ${res}=  performance_report  congestion
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
   ${res}=  performance_report  congestion
    Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Analytics_performancereport_backhaul
    Open Browser    ${masteruser}[URL]    Chrome
    Maximize Window
    qwebelement.typetext    ${masteruser}[uname]    username
    qwebelement.typetext    ${masteruser}[pswd]    password
    Qwebelement.clicktext    Login
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Log To Console    moving to performance report page
    Click Element      ${performance_report_link}
    Sleep  10s
    Click Element    ${performance_page_multiselect_input}
    Click Element    ${performance_page_input_unselect_all}
    Click Element    ${performance_page_backhaul_input}
    Click Element    ${select_all_checkbox}
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
   ${res}=  performance_report  backhaul
    Should Be Equal    ${res}    True
#select past 30 days
    Click Element    ${performace_page_calendar1}
    ${d} =  date_on_calendar  30
    Click Element    ${performace_page_calendar1_back}
    Click Text    ${d}  anchor=Tu  timeout=20s
    Click Element    ${select_all_checkbox }
    Click Element    ${download_performanceCsv_button}
    Verify Text    Success  5s
   ${res}=  performance_report  backhaul
    Should Be Equal    ${res}    True