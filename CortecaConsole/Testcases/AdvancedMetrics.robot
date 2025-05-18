*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/AdvancedMetricsKeywords.robot
Variables    ../Resources/TestDatas.py

*** Test Cases ***
BBDT-193876_NWCC_AIOC_TroubleshootingDashboard_46
    [Documentation]    Verify Advanced Metrics page options in Troubleshooting Dashboard
    ...                Check if the Advanced Metrics Page has the below fields
    ...                1. Icon, Last report, Devices, Downlink Avg., Uplink Avg.
    ...                2. Devices seen in the date range table
    ...                3. various Metric Graphs
    [Tags]    Both    smoke
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Move To AdvancedMetrics Tab
    Validate Advanced Metrics Page for Root and Extenders

BBDT-193878_NWCC_AIOC_TroubleshootingDashboard_48
    [Documentation]    Verify various Graph's validation in Advanced Metrics page
    ...                Check if the below metric graphs are plotted based on the respective data
    ...                x-axis - Time
    ...                y-axis - relevant metric measurement for the respective graph
    ...                1. Downlink Throughput (Mbps)
    ...                2. Uplink Throughput (Mbps)
    ...                3. Channel usage (%)
    ...                4. Signal strength (dBm)
    ...                5. SNR Ratio (DB)
    ...                6. TX power (dBm)
    ...                7. Noise Level (dBm)
    ...                8. Device Number (nos.)
    ...                9. TX bitrate (Mbps)
    ...                10. RX bitrate (Mbps)
    ...                11. TX packet error rate
    ...                12. RX packet error rate
    ...                13. TX packet retry rate
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Move To AdvancedMetrics Tab
    Validate Advanced Metrics Page Graph for Root and Extenders
    

