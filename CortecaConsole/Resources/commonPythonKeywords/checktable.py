import re
import os
import pandas as pd
import datetime

def remove_file_func_countrow(page):
    path= r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'{0}+.*\.csv'.format(page), f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    os.remove(final_path)

def checkcountrow(page):
    path = r"C:\Users\ladmin\Downloads"
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'{0}+.*\.csv'.format(page), f)]
    final_path = os.path.join(path, files[0])
    print(final_path)
    print(2)
    pdf = pd.read_csv(r"{0}".format(final_path), skiprows=2)
    print(pdf.shape)
    print(pdf['Count'])
    reboot_list = pdf['Count'].tolist()
    print(reboot_list)
    sorted_reboot = sorted(reboot_list, reverse=True)
    print(sorted_reboot)
    if reboot_list == sorted_reboot:
        remove_file_func_countrow(page)
        print('True')
        return 'True'
    else:
        remove_file_func_countrow(page)
        print('False')
        return 'False'

def nextday():
    n = datetime.datetime.today() + datetime.timedelta(days=2)
    return n.day

def date_on_calendar(days):
    today_date_str = datetime.datetime.today().strftime("%Y-%m-%d")
    date_1 = datetime.datetime.strptime(today_date_str, "%Y-%m-%d")
    end_date = date_1 - datetime.timedelta(int(days))
    print(end_date.day)
    return end_date.day

def check_calender_back():
    if date_on_calendar(30) == 1:
           return "False"
    else:
           return "True"
