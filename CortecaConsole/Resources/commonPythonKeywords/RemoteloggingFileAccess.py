
import pandas as pd
import os
import re
from datetime import datetime

def verifyOutput(string1):
    print(string1)
    print(len(string1))
    s2 = string1.replace("\n", "")
    print(len(s2))
    if "code: 0" in s2 and len(s2)>6:
        return "True"
    elif len(s2)>0:
        print("True")
        return "True"
    else:
        print("Fail")
        return "False"



def verify_copy_output(string1,string2):
    if string1.replace("\n", "") != string2.replace("\n", ""):
       return "True"
    else:
        return "False"


def check_remotelogging_file(strs,DownloadPath):
    path=DownloadPath
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'RemoteShellLog+.*\.txt', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    # File path for the Notepad file

    file_path = final_path # Replace with your file path
    # Open and read the file's content
    with open(file_path, "r") as file:
        notepad_text = file.read()
    if strs in notepad_text:
        print("Success")
        remove_file_func_remote(DownloadPath)
        return "True"
    else:
        print("Fail")
        remove_file_func_remote(DownloadPath)
        return "False"


def check_remote_logging_csv_file(DownloadPath):
    path=DownloadPath
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'Session+.*\.csv', f)]
    final_path = os.path.join(path,files[0])
    print(final_path)
    df = pd.read_csv(r"{0}".format(final_path))
    print("empty mac not there")
    print(df['id'])
    if len(df['id']) >= 3:
            print('True')
            remove_file_func_remote_csv(DownloadPath)
            return  'True'
    else:
            print('False')
            remove_file_func_remote_csv(DownloadPath)
            return 'False'



def remove_file_func_remote(DownloadPath):
    path=DownloadPath
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'RemoteShellLog+.*\.txt', f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    print("removed")
    os.remove(final_path)

def remove_file_func_remote_csv(DownloadPath):
    path=DownloadPath
    files = [f for f in os.listdir(r'{0}'.format(path)) if re.match(r'Session+.*\.csv', f)]
    files = list(files)
    final_path = path+"/"+str(files[0])
    print("removed")
    os.remove(final_path)

