# Token
API_URL_Auth_GetAPIToken = '/auth/token'
API_URL_Auth_RefreshToken = 'auth/token'
API_URL_Auth_GetUuid = 'auth/credentials/UUID'
#rohith
# Inventory
API_URL_GetSubscriber = '/subscribers/subscribers/?network_id=INDEX'
API_URL_CreateBeaconInventory = '/subscribers/subscribers'
API_URL_UpdateBeaconInventory = '/subscribers/subscribers/?update_account=true'
API_URL_DeleteBeaconSubscriber = '/subscribers/subscribers/INDEX?delete_topology=INDEX&delete_account=INDEX'
API_URL_DeleteBeacon = '/subscribers/subscribers/UUID/devices/INDEX'
API_URL_DeleteBeaconReset = '/subscribers/subscribers/UUID/devices/INDEX?force=true&factory_reset=true'
API_URL_DeleteBeaconSubscriberReset = '/subscribers/subscribers/UUID?delete_topology=INDEX&delete_account=INDEX&force=true&factory_reset=true'
API_URL_DeleteBeaconSubscriberReset_False = '/subscribers/subscribers/UUID?delete_topology=INDEX&delete_account=INDEX&force=true&factory_reset=false'
API_URL_DeleteDevices = '/subscribers/subscribers/UUID/devices'
API_URL_DeleteAccount = '/subscribers/subscribers/UUID'
API_URL_DeleteAssociation = 'dashboard-bff/subscribers?device_id=INDEX&page=0&size=1'
API_URL_SingleAssociation = '/subscribers/subscribers'
API_URL_BulkAssociation = '/subscribers/subscribers/upload'

# Overview
API_URL_MeshTopo = '/homehub/networks/INDEX/topology'
API_URL_MeshBackHaul = 'homehub/networks/INDEX/mesh?live=true'
API_URL_MeshTopo = 'homehub/networks/INDEX/topology'
API_URL_MeshBackHaul = 'homehub/networks/INDEX/mesh'
API_URL_DeviceStatus = 'dev_mng/devices/INDEX/status'
API_URL_DeviceStatus1 = 'device-management/devices/INDEX/status'
API_URL_DeviceStatusRefresh = '/device-management/devices/INDEX/status?refresh=true'
API_URL_DeviceStatus2 = 'devicehub/devices/INDEX/system/status'
API_URL_DeviceMgt = 'devicehub/devices/INDEX/router/management'

# WiFi Params
API_URL_WiFi_5G_Radio = 'devicehub/devices/INDEX/wifi/radios/wl0'
API_URL_WiFi_5G_Radio_Reset = 'devicehub/devices/INDEX/wifi/radios/wl0/reset'
API_URL_WiFi_5G_Vap = 'devicehub/devices/INDEX/wifi/vaps/wl0'
API_URL_WiFi_5G_Reset_Password = 'devicehub/devices/INDEX/wifi/vaps/wl0/reset_password'
API_URL_WiFi_5G_Clients = 'devicehub/devices/INDEX/wifi/vaps/wl0/assoclist'

API_URL_WiFi_5G_Radio_starhub = 'devicehub/devices/INDEX/wifi/radios/wl0.1'
API_URL_WiFi_5G_Radio_Reset_starhub = 'devicehub/devices/INDEX/wifi/radios/wl0.1/reset'
API_URL_WiFi_5G_Vap_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl0.1.v0'
API_URL_WiFi_5G_Reset_Password_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl0.1.v0/reset_password'
API_URL_WiFi_5G_Clients_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl0.1.v0/assoclist'

API_URL_B1_WiFi_24G_Radio = 'devicehub/devices/INDEX/wifi/radios/wl1'
API_URL_B1_WiFi_24G_Radio_Reset = 'devicehub/devices/INDEX/wifi/radios/wl1/reset'
API_URL_B1_WiFi_24G_Vap = 'devicehub/devices/INDEX/wifi/vaps/wl1'
API_URL_B1_WiFi_24G_Reset_Password = 'devicehub/devices/INDEX/wifi/vaps/wl1/reset_password'
API_URL_B1_WiFi_24G_Clients = 'devicehub/devices/INDEX/wifi/vaps/wl1/assoclist'

API_URL_B1_WiFi_24G_Radio_starhub = 'devicehub/devices/INDEX/wifi/radios/wl1.1'
API_URL_B1_WiFi_24G_Radio_Reset_starhub = 'devicehub/devices/INDEX/wifi/radios/wl1.1/reset'
API_URL_B1_WiFi_24G_Vap_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl1.1.v0'
API_URL_B1_WiFi_24G_Reset_Password_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl1.1.v0/reset_password'
API_URL_B1_WiFi_24G_Clients_starhub = 'devicehub/devices/INDEX/wifi/vaps/wl1.1.v0/assoclist'

API_URL_Clients = 'homehub/networks/INDEX/members'
API_URL_Home_Devices = 'homehub/networks?device_id=INDEX'

# Maintenance 
API_URL_Reset_Admin_Pass = 'devicehub/devices/INDEX/router/ui/reset_password'
API_URL_Reboot_Beacon = 'devicehub/devices/INDEX/system/reboot'
API_URL_Reset_Beacon = 'devicehub/devices/INDEX/system/factory'

# Statistics  
API_URL_WAN_Usage = 'stats/networks/INDEX/wan/usage?'
API_URL_WAN_Rate = 'stats/networks/INDEX/wan/rate?'
API_URL_Device_Usage = 'stats/networks/INDEX/members_usage?'
API_URL_Device_History_Usage = 'stats/networks/INDEX/members/CLNAME/usage_trend?'
API_URL_AP_ThroughPut = 'stats/devices/INDEX/wifi/throughput?'
API_URL_IPTV_Stats = 'stats/networks/INDEX/wan/iptv/rate_trend?'
API_URL_System_Info = '/devicehub/devices/INDEX/system/info'

# Batch update
API_URL_Batch_OUID = 'devicehub/queued_operations'
API_URL_Batch_MAC = 'devicehub/devices/INDEX/queued_operations'

# Network History  
API_URL_Network_History_All = 'activity-log/networks/INDEX/activity_traces/?'

# B2 radios and vaps/wl0

API_URL_B2_MTK_WiFi_24G_Radio = 'devicehub/devices/INDEX/wifi/radios/ra'
API_URL_B2_MTK_WiFi_24G_Radio_Reset = 'devicehub/devices/INDEX/wifi/radios/ra/reset'
API_URL_B2_MTK_WiFi_24G_Vap = 'devicehub/devices/INDEX/wifi/vaps/ra0.v0'
API_URL_B2_MTK_WiFi_24G_Reset_Password = 'devicehub/devices/INDEX/wifi/vaps/ra0.v0/reset_password'
API_URL_B2_MTK_WiFi_24G_Clients = 'devicehub/devices/INDEX/wifi/vaps/ra0.v0/assoclist'

API_URL_B2_MTK_WiFi_5G_Radio = 'devicehub/devices/INDEX/wifi/radios/rai'
API_URL_B2_MTK_WiFi_5G_Radio_Reset = 'devicehub/devices/INDEX/wifi/radios/rai/reset'
API_URL_B2_MTK_WiFi_5G_Vap = 'devicehub/devices/INDEX/wifi/vaps/rai0.v0'
API_URL_B2_MTK_WiFi_5G_Reset_Password = 'devicehub/devices/INDEX/wifi/vaps/rai0.v0/reset_password'
API_URL_B2_MTK_WiFi_5G_Clients = 'devicehub/devices/INDEX/wifi/vaps/rai0.v0/assoclist'

##
API_URL_WiFi_Radio = 'devicehub/devices/INDEX/wifi/radios/RADIOINTERFACE'
API_URL_WiFi_Radio_Reset = 'devicehub/devices/INDEX/wifi/radios/RADIOINTERFACE/reset'
API_URL_WiFi_Vap = 'devicehub/devices/INDEX/wifi/vaps/VAPSINTERFACE'
API_URL_WiFi_Reset_Password = 'devicehub/devices/INDEX/wifi/vaps/VAPSINTERFACE/reset_password'
API_URL_WiFi_Radio_Clients = 'devicehub/devices/INDEX/wifi/vaps/VAPSINTERFACE/assoclist'

##API_URL_PROVISION

API_URL_provision = 'device-provisioning/devices/INDEX?derive=false&nwcc=true&acs=false'
API_URL_verify = '/subscribers/subscribers/INDEX'

# UPDATE_API
API_UPDATE_UUID = '/subscribers/subscribers'
API_URL_MATCH = '/subscribers/subscribers/INDEX'
mac_delete_provision = '/device-provisioning/devices/INDEX?derive=false&nwcc=true&acs=false'
mac_delete_provision1 = '/device-provisioning/devices/INDEX?derive=false&nwcc=false&acs=true'
API_URL_CreateAccount = '/auth/credentials/subscribers'
API_UPDATE_GET_PROVISION = '/device-provisioning/devices/INDEX'

API_URL_Delete_Topo = '/subscribers/subscribers/INDEX?delete_topology=false&delete_account=true&delete_history=true&force=false&factory_reset=false'

API_URL_MAC_DELETE = '/homehub/networks/INDEX/topology?factory_reset=false'

API_URL_MESHNEW = '/homehub/networks?device_id=INDEX'

# Account Creation API
API_URL_CreateAccount = '/auth/credentials/subscribers'
API_URL_Associate_Device = '/subscribers/subscribers/INDEX/claim'
API_Validate ='/subscribers/subscribers/?network_id=INDEX'

#optical_interfaces
API_URL_FiberHealth = "/devicehub/devices/INDEX/optical_interfaces"

#MAPP Login
API_URL_login = 'login_app.cgi'
API_URL_logout = 'login_app.cgi?out'
API_URL_ZeroTouchOnboard = 'whw_zerotouchonb_app.cgi'
API_URL_ZeroTouchOnboardCheck = 'whw_zerotouchonb_status_app.cgi?gmode=check'
API_URL_ZeroTouchOnboardStart = 'whw_zerotouchonb_status_app.cgi?gmode=start'
API_URL_ZeroTouchOnboardPoll = 'whw_zerotouchonb_status_app.cgi?gmode=poll'
API_FAMILY_PROFILE= 'devicehub/devices/INDEX/router/management'
API_URL_Fsecure_Get='station-profiles/subscribers/INDEX/secure/subscription'
RESTAPI_FriendlyName_Test16_Scenario1_body_response = {'result': 0, 'reason': 201}
RESTAPI_FriendlyName_Test19_Scenario1_body_response = {
"returnCode":200,
"notConnectedBeacons":"undefined",
"connectedBeacons":"undefined"
}
RESTAPI_FriendlyName_Test19_Scenario2_body_response = {
"returnCode":200
}
RESTAPI_FriendlyName_Test19_Scenario3_body_response = {
"returnCode":200,
"notConnectedBeacons":0,
"connectedBeacons":1,
"beaconStatus":"undefined",
"MACAddress":"undefined",
"serialNo":"undefined"
}

API_DEVICE_MANAGEMENT_GET='device-management/devices/INDEX/status?refresh=true'
#WIFI Radio
API_URL_Radio = 'devicehub/devices/INDEX1/wifi/radios'
API_URL_RadioWiFi = 'devicehub/devices/INDEX1/wifi/radios/INDEX2'

API_DEVICE_MANAGEMENT_GET='device-management/devices/INDEX/status?refresh=true'
API_SECURE_SUBSCRIPTION_GET='station-profiles/subscribers/SUBSCRIBERID/secure/subscription'

API_ADMIN_GET_ALL_TENANT='admin/tenants'

#member profile
API_MEM_PROFILE= "/station-profiles/networks/INDEX/member_profiles"
