*** Settings ***
Resource    ../Resources/TestSpecificProcedures/FrontendGapsUSPPhase11/NodeMemoryCPUUsage.robot
Resource    ../Resources/TestSpecificProcedures/FrontendGapsUSPPhase11/PonMetricHealthStatus.robot
Variables    ../InputFiles/EnvironmentInput.py
Variables    ../Resources/TestDatas.py
Resource    ../Resources/TestSpecificProcedures/ExtenderOnboardingCGI.resource
Library     QWeb

*** Test Cases ***
NWCC_AIOC_USP_HomeDashboard_23
    [Documentation]    Yet to finish code!! In discussion
    ...    NWCC_AIOC_USP_HomeDashboard_23 | Verify the Memory Usage logic in WiFi point details page
    ...                Check the Memory usage logic based on the values from both Root & EXT WiFi point.
    ...                GOOD	<= 80
    ...                FAIR	80 to 90
    ...                BAD	>= 90
    ...                memory --> type - persistent or non-persistent
    ...                Command to increase Memory usage :
    ...                /tmp & /log files writing to increase memory using below command
    ...                Write files in /logs or cd / for Persistent Memory Usage % increment to be seen.
    ...                Use below command for Non-persistent Memory usage
    ...                dd if=/dev/zero of=/tmp/output.dat  bs=25M count=2
    ...                obuspa -c get Device.DeviceInfo.MemoryStatus.
    ...                Persistent Memory : df -kh /root [Size & Available]
    ...                Non-Persistent Memory : free [Total & Available]
    [Tags]    USP
    [Teardown]    QWeb.Close Browser
    Comment    Log To Console    Get Extender IPs
    Comment    GetExtenderIP
    Comment    Log To Console    Collect Node memory
    Comment    CollectNodeMemory
    Comment    Log To Console    Increase memory
    Comment    IncreaseMemoryAndCheck
    
BBDT-309867_BBDT-309869_NWCC_AIOC_USP_HomeDashboard_22_24
    [Documentation]    NWCC_AIOC_USP_HomeDashboard_22 | Verify the CPU Usage logic in WiFi point details page
    ...                Check the CPU logic based on the values from both Root & EXT WiFi point.
    ...                 GOOD	<= 80, FAIR	80 to 95, BAD	>= 95
    ...                Live CPU usage should be retrieved from root and extender and form API response.
    ...                CPU --> usage
    ...                Command to increase CPU load : yes > /dev/null &
    ...                obuspa -c get Device.DeviceInfo.ProcessStatus.CPUUsage
    ...
    ...                NWCC_AIOC_USP_HomeDashboard_24 | Verify the CPU usage Alarm sync in Events and Alarms page
    ...                Check for the CPU Usage Minor, Major & Critical Alarm trigger in the below pages while the Usage values gets changed1. 
    ...                Analytics dashboard - Events & Alarms page in all users list2. Troubleshooting Dashboard - Network History page Events & Alarms tab in individual user list.
    [Tags]    USP
    [Teardown]    QWeb.Close Browser
    ${Extcount}=    Get Length    ${meshNodes}
    ${ExtPresence}=    Run Keyword If    ${Extcount} > 0    Set Variable    Yes
    Log To Console    \nCollect Node CPU Usage
    Run Keyword And Continue On Failure    CollectNodeCPU
    Run Keyword And Continue On Failure    Run Keyword If    "${ExtPresence}"=="Yes"    ExecuteKeywordINExtender    CollectNodeCPU
    Log To Console    Increase CPU and Validated in Device Details Page
    Run Keyword And Continue On Failure    IncreaseCPU
    Run Keyword And Continue On Failure    Run Keyword If    "${ExtPresence}"=="Yes"    ExecuteKeywordINExtender    IncreaseCPU
    Log To Console    NWCC_AIOC_USP_HomeDashboard_22
    Run Keyword And Continue On Failure    ValidateCPUAlarm
    Run Keyword And Continue On Failure    Run Keyword If    "${ExtPresence}"=="Yes"    ExecuteKeywordINExtender    ValidateCPUAlarm
    Log To Console    NWCC_AIOC_USP_HomeDashboard_24
    Run Keyword And Continue On Failure    ValidateCPUAlarmAnalyticsDashboard
    Run Keyword And Continue On Failure    Run Keyword If    "${ExtPresence}"=="Yes"    ExecuteKeywordINExtender    ValidateCPUAlarmAnalyticsDashboard
    Log To Console    Kill CPU Threshold
    Run Keyword And Continue On Failure    KillCPUThreshold
    Run Keyword And Continue On Failure    Run Keyword If    "${ExtPresence}"=="Yes"    ExecuteKeywordINExtender    KillCPUThreshold

BBDT-309878_NWCC_AIOC_USP_TroubleshootingDashboard_08
    [Documentation]    BBDT-309878 NWCC_AIOC_USP_TroubleshootingDashboard_08 | Verify PON Metrics and Health status logic in Overview page
	...		Check the PON metrics and Health status logic to notify GOOD, FAIR and BAD according to the below logic,
	...		PON Range:
	...		POOR Rx signal > -8dBm (or) Rx signal < -27dBm
	...		FAIR -11dBm <= Rx signal <= - 8dBm (or) -27dBm <= Rx signal <= - 25dBm
	...		GOOD FAIR -25dBm < Rx signal < -11dBm
	...		Ex: 
	...		POOR -> -7 ,-6, -5   or -28 ,-29 ,-30 
	...		FAIR ->  -8 ,-9, -10, -11 or -25, -26 ,-27 
	...		GOOD -> -12  to -24
	...		---------------------------------------------------------------------------------------------------------------------
	...		Tx signal level:
	...		GPON ONT :
	...		POOR Tx signal > 5dBm (or) Tx signal < 0.5dBm
	...		FAIR 0.5 dBm <= Tx signal <= 1 dBm (or) -4.5dBm <= Tx signal <= 5dBm
	...		GOOD FAIR 1dBm < Tx signal < 4.5dBm
	...		Ex:
	...		POOR -> 0 ,-1, 0.4 or 6, 7, 8
	...		FAIR ->  0.5, 0.6, 0.9,  1 or 4.5,4.6,4.7..  5
	...		GOOD -> 2  to 3
	...
	...		XS ONT:
	...		BAD Tx signal > 10dBm OR Tx signal < 4dBm
	...		FAIR 2 dBm < Tx signal < 4 dBm OR   9dBm < Tx signal < 10dBm
	...		GOOD 2dBm < Rx signal < 9dBm
	...		Ex:
	...		BAD - >11,12, 13  3,2,1,-1,-2
	...		FAIR -> 3 or 8
	...		GOOD -> 4 5 6 7
	...		---------------------------------------------------------------------------------------------------------------------
	...		Transceiver temperature:
	...		POOR T> 90C
	...		FAIR 85C <= T <= 90C
	...		GOOD T< 85C
	...		Ex:
	...		POOR -> 91,92 
	...		FAIR ->  85 to 90
	...		GOOD -> 84,83
	...		=====================================================================
	...		Overall health indicator - Fiber access:
	...		It is a combination of the qualification of the metrics above: Good =1 ; Fair = 0.5 ; Poor = 0
	...		Overall quality indicator (%) = 0.3 * OpticalSignalLevel qualification + 0.3 * TransmitOpticalLevel qualification + 0.4 * X_ALU-COM_TransceiverTemperature qualification
	...		POOR Value < 70%
	...		FAIR 70% =< Value < 85%
	...		GOOD Value >=85%
    [Tags]    USP    Runner
    [Teardown]    QWeb.Close Browser
    LoginConsoleCheckFiberHealth


	
    



    

        

    
    
