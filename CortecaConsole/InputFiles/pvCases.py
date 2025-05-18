from EnvironmentInput   import  WifiBandList2,DeviceBandList



# Check which band category 'a' belongs to
def check_band(device_band_list, band):
    for key, values in device_band_list.items():
        if band in values:
            return key
    return "Not found"


def  return_list_of_band(device_band_list, band):
     f=check_band(device_band_list, band)
     return  WifiBandList2[f]




