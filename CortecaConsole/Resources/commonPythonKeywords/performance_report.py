import re
import os
import pandas as pd

def remove_file_func_performance_report(page):
    path= r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'{0}+.*\.csv'.format(page), f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    os.remove(final_path)

def performance_report(types):
    path = r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'tenant3+.*\.csv', f)]
    print(files)
    i=0
    tl=len(files)
    final_check=False
    while i<tl:
        final_path = os.path.join(path,files[i])
        print("check the deviceid performance report  has any deviceid not null values")
        df = pd.read_csv(r"{0}".format(final_path))
        if types=='reboot':
            not_empty_ip = df['DEVICEID'].isna().any()
            print("check the timestamp not null in the csv files")
            not_empty_created_at = df['TIMESTAMP'].isna().any()
            print("check the timeoff not null in the csv files")
            not_empty_client_id = df['TIMEOFF[s]'].isna().any()
            not_empty_reason=df['REASON'].isna().any()
            if not_empty_reason == False and not_empty_client_id== False and not_empty_created_at==False and not_empty_ip==False:
                final_check='True'
            else:
                final_check='False'
        if types=='noise' or types=='congestion' or types=='coverage':
            not_empty_networkid=df['NETWORKID'].isna().any()
            not_empty_MIN=df['MIN'].isna().any()
            not_empty_AVG=df['AVG'].isna().any()
            not_empty_MAX=df['MAX'].isna().any()
            not_empty_FREQUENCY=df['FREQUENCY'].isna().any()
            print("check the timestamp not null in the csv files")
            if types=='coverage':
                not_empty_memberid = df['MEMBERID'].isna().any()
                if not_empty_MIN==False and not_empty_memberid==False and not_empty_MAX==False and not_empty_AVG==False and not_empty_FREQUENCY==False and not_empty_networkid==False:
                    final_check='True'
                else:
                    print("may one of fields has empty string please the csv files")
                    final_check='False'
            else:
                not_empty_ip = df['DEVICEID'].isna().any()
                if not_empty_MIN==False and not_empty_ip==False and not_empty_MAX==False and not_empty_AVG==False and not_empty_FREQUENCY==False and not_empty_networkid==False:
                    final_check='True'
                else:
                    print("may one of fields has empty string please the csv files")
                    final_check='False'
        if types=='backhaul':
            not_empty_ip = df['DEVICEID'].isna().any()
            not_empty_networkid=df['NETWORKID'].isna().any()
            not_empty_starttime = df['STARTTIME'].isna().any()
            not_empty_endtime = df['ENDTIME'].isna().any()
            not_empty_endreason= df['ENDREASON'].isna().any()
            if  not_empty_ip == False and not_empty_networkid == False and not_empty_endtime==False and not_empty_starttime==False and not_empty_endreason==False:
                final_check = 'True'
            else:
                final_check='False'
        if types=='claim' or types =='newWiFi' or types=='cloud_disconnections':
            not_empty_ip = df['DEVICEID'].isna().any()
            not_empty_timestamp = df['TIMESTAMP'].isna().any()
            print(not_empty_ip)
            if not_empty_ip == False and not_empty_timestamp == False:
                final_check ='True'
            else:
                final_check = 'False'
        i+=1
        remove_file_func_performance_report('tenant3')
    return final_check
