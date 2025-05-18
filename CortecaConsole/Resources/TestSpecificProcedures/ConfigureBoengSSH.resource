*** Settings ***
Library         SSHLibrary
Library         String
Library         Collections
Variables        ../../InputFiles/EnvironmentInput.py
Resource        ../KeywordDefinition/Sshkeywords.resource
*** Keywords ***
ConfigureBoeng
    SSHExecute    ${BooengDM}
    SSHExecute    ${ConfigureBoeng}
    SSHExecute    ${EnableBoeng}
    SSHExecute    ${BooengDM}
    SSHExecute    ${EnableNTP}
    SSHExecute    ${ConfigureTZ}
    SSHExecute    ${ConfigureNTPServer}
    SSHExecute    ${TimeDM}
    SSHExecute    date
    SSHExecute    reboot
    Log To Console    \n\nSleep added for device to come online\n\n
    Sleep Count    360
    ${outputDict}=    BoengAgentStatus
    Log Many    ${outputDict}   BoengAgentStatus
    ${expected_status}=    Get From Dictionary    ${outputDict}    OnboardConnectionStatus
    ${status}=    Run keyword and Return Status    Should Be Equal    ${expected_status}    ConnectionSuccess
    Run Keyword If    '${status}'=='False'    BOENGAgentStatusRootDown
    Run Keyword And Continue On Failure    Validate_Process    ${Root}[ip]    ${Root}[telnet_vtysh]
    SSHExecute    ${ConfigureTZ}
    
BoengAgentStatus
    ${BOENGAgentDict}=    Create Dictionary
    ${output_socket}=    SSHExecute    ${BooengDM}
    ${output_socket}=    Split To Lines    ${output_socket}
    ${output_socket_lines}=    get length    ${output_socket}
    log    ${output_socket_lines}=
    log    ${output_socket}=
    ${end_index}=    Evaluate    ${output_socket_lines}-4
    FOR    ${i}    IN RANGE    3    ${end_index}
        ${ELEMENT}=    Strip String    ${output_socket}[${i}]    both
        @{ELEMENT}=    split String    ${ELEMENT}    =
        ${key}=    Get From List    ${ELEMENT}    0
        ${key}=    Strip String    ${key}    both
        ${status}=    Run keyword and Return Status    Should be equal    ${key}    ${EMPTY}
        IF    ${status}    CONTINUE
        ${val}=    Get From List    ${ELEMENT}    1
        ${val}=    Strip String    ${val}    both
        Set To Dictionary    ${BOENGAgentDict}    ${key}    ${val}
    END
    log    ${BOENGAgentDict}
    RETURN    ${BOENGAgentDict}

BOENGAgentStatusRootDown
    ${output_socket}=    SSHExecute    ${boengprocess}
    ${output_socket}=	Split To Lines	${output_socket}		
    ${output_socket_lines}=	get length	${output_socket}		
    ${output_socket_lines}=	Convert To String	${output_socket_lines}		
    Log	${output_socket_lines}			
    Log	${output_socket}			
    Sleep	3s			
    ${status}=	Run Keyword And Return Status	Should Be Equal As Integers	${output_socket_lines}	2
    Log	${status}			
    Sleep	3s			
    Run Keyword If	'${status}'=='False'	Log To Console	BOENG Agent is Not Running	
    Run Keyword If	'${status}'=='False'	Log	BOENG Agent is Not Running
    Run Keyword If	'${status}'=='False'    Fail    BOENG Agent is Not Running
    Sleep	3s

Validate_Process
    [Arguments]    ${ipaddress}    ${password2}
    Log    Check the L1, L2 and MAPP URLs
    Log    ${DeviceStream}
    ${val}	SSHExecute    	${L1Server}    ${ipaddress}    ${password2}
    Log Many	${val}
    Run Keyword If	'${DeviceStream}'=='HA'	Should Contain	${val}	${cloudDetail['L1Server']}
    ...	ELSE	Should Not Contain	${val}	${cloudDetail['L1Server']}
    Comment	Run Keyword and Continue on Failure	Should Contain	${val}	${cloudDetail['L1Server']}
    ${val}	SSHExecute    ${L2Server}    ${ipaddress}    ${password2}
    Log Many	${val}
    Run Keyword If	'${DeviceStream}'=='HA'	Should Contain	${val}	${cloudDetail['L2Server']}
    ...	ELSE	Should Not Contain	${val}	${cloudDetail['L2Server']}
    Comment	Run Keyword and Continue on Failure	Should Contain	${val}	${cloudDetail['L2Server']}
    ${val}	SSHExecute    ${Remoteurl}    ${ipaddress}    ${password2}
    Log Many	${val}
    Run Keyword and Continue on Failure    Run Keyword If    '${ipaddress}'=='${root}[ip]'    Should Contain	${val}	${cloudDetail['remoteMobileAccess']}
    ${output}    Run Keyword If	'${DeviceStream}'=='HA'	SSHExecute   ${netstat_plas}    ${ipaddress}    ${password2}
    Run Keyword If	'${DeviceStream}'=='HA'    Should Contain    ${output}    ESTABLISHED
    ${output}    Run Keyword If	'${DeviceStream}'=='USP'    SSHExecute    ${MQTT_status}    ${ipaddress}    ${password2}
    Run Keyword If	'${DeviceStream}'=='HA'    Should Contain    ${output}    Connected
    ${output}    Run Keyword If	'${DeviceStream}'=='USP'    SSHExecute    ${netstat_obuspa}    ${ipaddress}    ${password2}
    Run Keyword If	'${DeviceStream}'=='HA'    Should Contain    ${output}    ESTABLISHED
    Log	Boeng is success
    Log To Console    Boeng is success
    ${val}    SSHExecute    date    ${ipaddress}    ${password2}
    Log Many    ${val}
    Run Keyword And Ignore Error    ${val}    SSHExecute    ${messages}    ${ipaddress}    ${password2}
    Log Many    ${val}
    Run Keyword And Ignore Error    ${val}    SSHExecute    ${messages_component}    ${ipaddress}    ${password2}
    Log Many    ${val}

ONT_CheckCore
    ${output}=    SSHExecute    ${core}
    ${count}	Get Line count	${output}		
    ${stat}	Run Keyword and return status	Should be equal	${count}	${val}
    ${stat1}	Run Keyword and return status	Should contain	${output}	No such file or directory
    Run Keyword If	'${stat}'=='True' or '${stat1}'=='True'	Log	No core present	
    ...	ELSE	Fail		
    Log    Check core in Extenders
    ${node}=     Set Variable  1
    ${index}=    Set Variable    0
    FOR    ${i}    IN    @{Ext_ip}
        SSHExecute    ${core}    ${Ext_ip}[${index}]    ${Ext${node}}[telnet_vtysh]
         ${count}	Get Line count	${output}
        ${stat}	Run Keyword and return status	Should be equal	${count}	${val}
        ${stat1}	Run Keyword and return status	Should contain	${output}	No such file or directory
        Run Keyword If	'${stat}'=='True' or '${stat1}'=='True'	Log	No core present
        ...	ELSE	Fail
        ${node}=    Evaluate    ${node} + 1
        ${index}=    Evaluate    ${index} + 1
    END