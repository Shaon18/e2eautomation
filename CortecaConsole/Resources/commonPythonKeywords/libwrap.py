import csv
import pandas as pd
import os
import re
from CortecaConsole.InputFiles.EnvironmentInput import Downloads
from datetime import datetime
import requests
import json

def remove_file_func_unauth():
    path=Downloads
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'Unauthorized+.*\.csv', f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    print(final_path)
    os.remove(final_path)

def Macpresentunauth(MAC):
    path=Downloads
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'Unauthorized+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    is_text_present = df['Client ID'].str.contains(MAC).any()
    not_empty_ip = df['IP'].isna().any()
    not_empty_created_at=df['First Contacted'].isna().any()
    not_empty_client_id=df['Client ID'].isna().any()
    print("not_empty_ip")
    print(not_empty_ip)
    print("not_empty_client_id")
    print(not_empty_client_id)
    print("is text present")
    print(is_text_present)
    if is_text_present == True and not_empty_ip == False and not_empty_created_at ==False and not_empty_client_id==False:
        return "True"
    else:
        return "False"

def remove_file_func_deployment():
    path= r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    os.remove(final_path)

def Macpresentdeployment():
    path=  r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    not_empty_mac = df['MAC'].isna().any()
    res = []
    if not_empty_mac == True:
        for mac in df['MAC']:
            result = df[df['MAC'] == mac]
            online_satus = result['Online status']
            if online_satus == 'TRUE':
                not_empty_customer_id = result['Customer ID'].isna()
                not_empty_Firmware = result['Firmware version'].isna()
                not_empty_releaseV = result['Release Version'].isna()
                not_empty_model = result['Model Name'].isna()
                not_empty_onboardtime = result['Onboarded time'].isna()
                not_empty_lastboot = result['Last boot'].isna()
                not_empty_lastoffline = result['Last offline'].isna()
                not_empty_firmwaredate = result['Firmware update date'].isna()
                not_empty_manufaturer = result['Manufacturer'].isna()
                not_empty_timezone = result['Time zone'].isna()
                not_empty_serial = result['Serial Number'].isna()
                not_empty_tenant = result['Tenant ID'].isna()
                not_empty_hardware = result['Hardware Version'].isna()

                if not_empty_firmwaredate == True and not_empty_customer_id==True and not_empty_Firmware == True and not_empty_releaseV == True and not_empty_model == True and not_empty_model == True and not_empty_onboardtime == True and not_empty_lastboot == True and not_empty_lastoffline == True and  not_empty_manufaturer==True and not_empty_timezone == True and not_empty_serial == True and not_empty_tenant==True and not_empty_hardware==True:
                   return 'True'
                else:
                    res.append(mac)
        print(res)
    else:
        return "False"
    remove_file_func_deployment()


def Macpresent(mac):
    path=  r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    if mac in df['MAC'].values:
        return 'True'
    else:
        return 'False'

#checks the last reboot date with current date of the given mac in he deployment report
def check_deployment_reboot_date(mac):
    path=  r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    result = df[df['MAC'] == mac]
    reboot_date = str(result['Last boot'])
    print(reboot_date[:16])
    current_date = datetime.now()
    formatted_date = str(current_date.strftime("%Y-%m-%d"))
    print(formatted_date)
    if formatted_date in reboot_date:
        print("True")
        return "True"
    else:
        print("False")
        return "False"

def check_deployment_mac_status(mac, statuscheck):
        path = r"C:\Users\ladmin\Downloads"
        files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
        final_path = os.path.join(path, files[0])
        print(final_path)
        df = pd.read_csv(r"{0}".format(final_path))
        result = df[df['MAC'] == mac]
        status = result["Online status"]
        print(status)
        if status==statuscheck:
            return "true"
        else:
            return "false"

def check_deployment_firmware_update_status(mac, firmwareVersion):
    path=  r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'deployment+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    result = df[df['MAC'] == mac]
    firmware_version_in_file = str(result['Firmware version'])
    firmware_date = str(result['Firmware update date'])
    print(firmware_date[:16])
    current_date = datetime.now()
    formatted_date = str(current_date.strftime("%Y-%m-%d"))
    if firmware_version_in_file == firmwareVersion and firmware_date == formatted_date:
        return "true"
    else:
        return "false"

def file_upload_api(url,auth_token, csvfile):
    """File upload API, file expected format is text/scv"""
    files = [('file', (csvfile, open(csvfile, 'rb'), 'text/csv')) ]
    headers = {'Authorization': 'Bearer %s'%auth_token,'accept' : '* / * ' }
    try:
        print("----Calling  API----\n" +url)
        response = requests.request("POST", url, headers=headers, files=files)
        response.raise_for_status()
        if response.status_code == 200:
            print(" Successfully"+ "Success Code: " + str(response.status_code))
            return "True"
        else:
            return "Bulk  failed due to Error Code: " + str(response.status_code)  + response.json() + str(response)
    except Exception as e:
        return "Bulk  failed due to Exception :" + str(e)
