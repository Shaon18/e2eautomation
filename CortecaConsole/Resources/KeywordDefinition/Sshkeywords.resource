*** Settings ***
Library         SSHLibrary
Library         String
Library         Collections
Variables        ../../InputFiles/EnvironmentInput.py

*** Keywords ***
SSHLogin
    [Arguments]    ${ipaddress}    ${password2}
    SSHLibrary.Open Connection    ${ipaddress}
    Login    ${Root}[telnet_username]    ${Root}[telnet_password]
    Set Client Configuration    prompt=${ssh_prompt}
    ${stdout}=    Run Keyword And Return Status    Write    en
    ${stdout}=    Read Until    \#
    ${stdout}=    Run Keyword And Return Status    Write    shell
    ${stdout}=    Read Until    2:
    ${stdout}=    Run Keyword And Return Status    Write    ${password2}

SSHExecute
    [Arguments]    ${command}    ${ipaddress}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]
    SSHLogin    ${ipaddress}    ${password2}
    Sleep    2s
    ${stdout}=    Read Until    \#
    ${stdout}=    Write    ${command}
    Sleep    2s
    ${output}=    Read Until Prompt    
    Sleep    2s
    log    ${output}
    Close All Connections
    RETURN    ${output}

Sleep Count
    [Arguments]    ${sleepTime}    ${sleepInterval}=60
    ${range}	evaluate	${sleepTime}/${sleepInterval}
    FOR	${i}	IN RANGE	${range}
        ${left}=	Evaluate	${range}-${i}
        ${left1}=	Convert To Integer	${left}
        Log to Console	Sleep Left : ${left1} Minutes
        Sleep	${sleepInterval} s
    END

HA_bringup
    [Arguments]    ${ipaddress}    ${password2}
    SSHLogin    ${ipaddress}     ${password2}
    SSHExecute    cfgcli -s InternetGatewayDevice.Time.NTPServer1 216.239.35.4
    Sleep    2s
    SSHExecute    cfgcli -s InternetGatewayDevice.Time.X_ALU-COM_LocalTimeZone IST-5:30
    Sleep    2s
    SSHExecute     cfgcli -s InternetGatewayDevice.Time.Enable true
    Sleep    2s
    SSHExecute     cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.L1Server.URL https://verne.stg.homewifi.nokia.com
    Sleep    3s
    SSHExecute     cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.L2Server.URL https://xca-back.stg.homewifi.nokia.com
    Sleep    2s
    SSHExecute    cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.RemoteMobileAccess.URL https://l1api.stg.homewifi.nokia.com
    Sleep    2s
    SSHExecute     ubus call fonendoscope restart '{"process":"plasmodium"}'
    Sleep    2s
    SSHExecute     ubus call fonendoscope restart '{"process":"plasmodium"}'
    Sleep    2s

cloudconnectioncheck
    [Arguments]    ${ipaddress}    ${password2}
    IF    '${DeviceStream}'=='HA'
        ${ssh_output}=    SSHExecute    ${restart_plasmodium}
        Sleep    10s
        ${ssh_output}=    SSHExecute    netstat -anp | grep -i plas
        Should Contain    ${ssh_output}    ESTABLISHED
    ELSE IF    '${DeviceStream}'=='USP'
        ${ssh_output}=    SSHExecute    cat /tmp/mqtt_nwcc_status
        Should Contain    ${ssh_output}    Connected
    END

SSHExecute Till delay is over
    [Arguments]    ${command}   ${delay}=5s     ${ipaddress}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]
    SSHLogin    ${ipaddress}    ${password2}
    Sleep    2s
    ${stdout}=    Read Until    \#
    ${stdout}=    Write    ${command}
    ${output}    Read    delay=${delay}
    Log    ${output}
    Log To Console    ${output}
HA_Configuration
   SSHExecute    ${EnableNTP}
   SSHExecute    ${ConfigureTZ}
   SSHExecute    ${ConfigureNTPServer}
   SSHExecute    ${TimeDM}
   SSHExecute    date
   SSHExecute    ${DisableBoeng}
   SSHExecute    ${ConfigureL1Server}
   SSHExecute    ${ConfigureL2Server}
   SSHExecute    ${ConfigureRemoteurl}
   Log To Console    \n\nSleep added for device to come online with could configuration\n\n
   Sleep Count    180
   ${ssh_output}=    SSHExecute    netstat -anp | grep -i plas
   Should Contain    ${ssh_output}    ESTABLISHED

WAN Config in ONT
    Log To Console    setting ontlock as false
    SSHExecute    cfgcli -s InternetGatewayDevice.UserInterface.X_ASB_COM_ONTLOCK 0
    Sleep    3s
    Log To Console    deleting existing wan configs if present
    SSHExecute    cfgcli del InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.
    Sleep    3s
    SSHExecute    cfgcli del InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.
    Sleep    3s
    SSHExecute    cfgcli del InternetGatewayDevice.WANDevice.1.WANConnectionDevice.3.
    Sleep    3s
    Log To Console    adding device configuration
    SSHExecute    cfgcli add InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.
    Sleep    3s
    SSHExecute    cfgcli add InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
    Sleep    3s
    Log To Console    pushing WAN settings
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.X_CT-COM_WANGponLinkConfig.Mode 2
    Sleep    3s
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.X_CT-COM_WANGponLinkConfig.VLANIDMark 981
    Sleep    3s
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ConnectionType IP_Routed
    Sleep    3s
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.X_CT-COM_IPMode 1
    Sleep    3s
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.X_CT-COM_ServiceList TR069,INTERNET
    Sleep    3s
    SSHExecute    cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.Enable 1
    Sleep    3s
    Log To Console    WAN settings pushed successfully