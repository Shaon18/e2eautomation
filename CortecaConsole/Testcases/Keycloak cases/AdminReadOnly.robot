*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/Keycloakresources.resource
Resource        ../../Resources/TestSpecificProcedures/keycloak/AdminReadOnly.resource

Resource        ../../Resources/TestSpecificProcedures/keycloak/FullAccess.resource
Resource        ../../Resources/TestSpecificProcedures/keycloak/caregaent.resource



*** Test Cases ***

BBDT-358289|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_06 | Home Controller - Admin Read Only Access
    [Documentation]    Step1: Action: Connect device to corteca both L1 and L2
      ...                  Result: Device should be online in both L1 and L2

      ...                  Step2: Action: Open Corteca console with above sub group user
      ...                  Expected Result: Home, troubleshooting, Wifi Optimization, Admin and Analytics, Network Monitoring apps should be shown

      ...                  Step3: Action: Login to device via home troubleshooting dashboard
      ...                  Expected Result: Should be able to see live updates and set operations also should be allowed

      ...                  Step4: Action: Open Admin dashboard
      ...                  Expected Result: Provisioning, CustomerID association, Deployment reports amenu should be shown

      ...                  Step5: Action: Click provisioning
      ...                  Expected Result: Single, Bulk, Validate, Delete, Delete bulk options should be shown

      ...                  Step6: Action: Click CustomerID association
      ...                  Expected Result: Network device association, Update, Bulk, Validate and Advance deleting options should be shown

      ...                  Step7: Action: Click Deployment reports
      ...                  Expected Result: Deployment reports and App deployment report should be shown

      ...                  Step8: Action: Click Analytics
      ...                  Expected Result: All menus should be shown

      ...                  Step9: Action: Click WiFi Optimization
      ...                  Expected Result: All menus expect geographical deployment should be shown and group/area profile creation option should not be shown

      ...                  Step10: Action: Click Network Monitoring
      ...                  Expected Result: It should redirect to grafana
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_readonly}
    Verify Corteca Elements For Readonly
    set permission allowed    ${payload_readonly}
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Move To Page     Admin
    Run Keyword And Continue On Failure    Check Admin Page Options
    Run Keyword And Continue On Failure    Provisioning
    Run Keyword And Continue On Failure    CustomerIDAssociation
    Run Keyword And Continue On Failure    Deployment Report
    Move To Page     Analytics
    Run Keyword And Continue On Failure    Analytics Dashboard Check
    Move To Page     WiFi Optimization
    Run Keyword And Continue On Failure    Wifi Optimization Check For Readonly
    Move To Page     Network Monitoring
    Run Keyword And Continue On Failure    Network Monitoring






