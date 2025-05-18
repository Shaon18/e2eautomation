*** Settings ***
Resource    ../Resources/TestSpecificProcedures/WiFiOptimizationDashboardKeywords.resource
Variables    ../Resources/TestDatas.py

*** Test Cases ***
BBDT-217640_BBDT-217641_BBDT-217642_NWCC_AIOC_WiFiOptimizationDashboard_24_25_26
    [Documentation]     The Scripts Cover Below 3 Testcases
     ...   ${\n}    BBDT-217640_NWCC_AIOC_WiFiOptimizationDashboard_24 | Verify Create new Model Group
     ...   ${\n}    BBDT-217641_NWCC_AIOC_WiFiOptimizationDashboard_25 | Verify Edit Model Group
     ...   ${\n}    BBDT-217642_NWCC_AIOC_WiFiOptimizationDashboard_26 | Verify Delete Model Group
     ...   ${\n}    Steps includes below
     ...                1. Check the Create Model Group has below optionsName, Model Profile and Supplier & modelcheck both Save changes and cancel options
     ...                2. Check if already created Model Group can be Edited and saved
     ...                3. Check if the created Model Group can be deleted.
     [Tags]    Both    pvcase
     [Teardown]    Group Model Teardown    ${ModelGroupCreate}    ${existingData}
     Log To Console    **** Checking and saving the details of Group model data for ${Root}[model_L2] if already present ****
     ${existingData}    Search Groups Model    ${Root}[model_L2]
     Set Test Variable    ${existingGroupModelData}    ${existingData}
     Log To Console    **** Create new group model profile ****
     Create Model Groups    ${ModelGroupCreate}[ModelName]    ${ModelGroupCreate}[ModelProfile]    ${Root}[model_L2]    ${existingGroupModelData}
     Log To Console    **** Verify Model Name In Device Feature Status ****
     Verify Model Name In Device Feature Status    ${ModelGroupCreate}[ModelName]    ${ModelGroupCreate}[ModelProfile]    ${Root}[model_L2]
     Log To Console    **** Edit Model Group ****
     Group Model Edit    ${ModelGroupCreate}[ModelName]    ${ModelGroupCreate}[ModelProfileEditName]
     Log To Console    **** Verify Model Name In Device Feature Status After edit ****
     Verify Model Name In Device Feature Status    ${ModelGroupCreate}[ModelName]    ${ModelGroupCreate}[ModelProfileEditName]    ${Root}[model_L2]
