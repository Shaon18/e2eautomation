import json
import jsonschema
import jmespath
from json_payload_validator import validate

global response_dict, response_sample_dict
# response_dict = {}
# response_sample_dict = {}
global arr
arr = []
global str1
str1 = ''
global flag
flag = 1
global undefined_arr
undefined_arr = []
global flag_list
flag_list = 0


def parse_exp_undefined_keys(p1):
    print("response_sample is " + str(p1))
    if type(p1) is dict:
        for key, value in p1.items():
            print("Value is ====>" + str(value))
            print(key)
            if type(value) is dict:
                arr.append(key)
                print(arr)
                parse_exp_undefined_keys(value)
                if len(arr) != 0:
                    arr.pop()
            elif type(value) is list:
                index_list = 0
                print("Inside list func2" + str(p1))
                for item in value:
                    print("ITEM LIST is" + str(item))
                    k1 = key + '[' + str(index_list) + ']'
                    print(k1)
                    arr.append(k1)
                    print("Arr is" + str(arr))
                    parse_exp_undefined_keys(item)
                    print("Return to list ")
                    index_list = index_list + 1
                    if len(arr) != 0:
                        print("Popping!!! last value from list inside dict arr " + str(arr))
                        arr.pop()
                        print("After poppingg!!! " + str(arr))

            else:
                print("Else of dict ")
                arr.append(key)
                print(arr)
                global str1
                str1 = ''
                length = len(arr)
                for ind in range(length):
                    print("Index is " + str(ind))
                    if ind != 0 and ind != length - 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        elatind2 = arr[ind + 1]
                        str1 = str1 + str(elatind)
                        if not (elatind2.startswith('[') and elatind.startswith('[')):
                            str1 = str1 + '.'
                    elif ind == 0 and length != 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        elatind2 = arr[ind + 1]
                        str1 = str1 + str(elatind)
                        if not (elatind2.startswith('[') and elatind.startswith('[')):
                            str1 = str1 + '.'
                    elif ind == 0 and length == 1:
                        elatind = arr[ind]
                        str1 = str1 + str(elatind)
                    elif ind == length - 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        str1 = str1 + str(elatind)
                    print("str1 is " + str1)
                # key1 = deep_get(response_dict, str1)
                # key2 = deep_get(response_sample_dict, str1)
                key2 = jmespath.search(str1, response_sample_dict)
                print("key2 is " + str(key2))
                if str(key2) == 'undefined':
                    undefined_arr.append(str1)
                str1 = ''

                if len(arr) != 0:
                    lastkey = arr[len(arr) - 1]
                    print(lastkey)
                    if '[' not in lastkey:
                        print("Popping!!! last value from arr " + str(arr))
                        arr.pop()
                        print("After poppingg!!! " + str(arr))


    elif type(p1) is list:
        index_list = 0
        key = ''
        print("Inside list func3")
        for item in p1:
            k1 = key + '[' + str(index_list) + ']'
            print(k1)
            arr.append(k1)

            print("Item " + str(item))
            parse_exp_undefined_keys(item)

            index_list = index_list + 1
            if len(arr) != 0:
                print("Popping!!! last value from parse arr " + str(arr))
                arr.pop()
                print("After poppingg!!! " + str(arr))
    else:
        print("ELSE LOOP")
        if len(arr) == 0:
            print("Enter if loop")
            if response_dict != response_sample_dict:
                print("Enter if loop success compare resp when arr is empty. [A string json response]")
                flag = 0
                return flag
            else:
                flag = 1
                return flag
        str1 = ''
        length = len(arr)
        for ind in range(length):
            print("Index is " + str(ind))
            if ind != 0 and ind != length - 1:
                print(arr[ind])
                elatind = arr[ind]
                elatind2 = arr[ind + 1]
                str1 = str1 + str(elatind)
                if not (elatind2.startswith('[') and elatind.startswith('[')):
                    str1 = str1 + '.'
            elif ind == 0 and length != 1:
                print(arr[ind])
                elatind = arr[ind]
                elatind2 = arr[ind + 1]
                str1 = str1 + str(elatind)
                if not (elatind2.startswith('[') and elatind.startswith('[')):
                    str1 = str1 + '.'
            elif ind == 0 and length == 1:
                elatind = arr[ind]
                str1 = str1 + str(elatind)
            elif ind == length - 1:
                print(arr[ind])
                elatind = arr[ind]
                str1 = str1 + str(elatind)
            print("str1 is " + str1)
        key2 = jmespath.search(str1, response_sample_dict)
        print("value from sample dict is " + str(key2))
        if str(key2) == 'undefined':
            undefined_arr.append(str1)
        str1 = ''
        if len(arr) != 0:
            lastkey = arr[len(arr) - 1]
            print(lastkey)
            if '[' not in lastkey:
                print("Popping!!! last value from arr " + str(arr))
                arr.pop()
                print("After poppingg!!! " + str(arr))


def api_response_get_undefined_values(response_sample_di):
    global response_dict, response_sample_dict, undefined_arr
    undefined_arr = []
    response_sample_dict = response_sample_di
    parse_exp_undefined_keys(response_sample_dict)
    while len(arr) != 0:
        arr.pop()
    print("Undefined keys are " + str(undefined_arr))
    return undefined_arr


def parse_exp(p1):
    print("Calling parse func1")
    global flag
    print("p1 is " + str(p1))
    if type(p1) is dict:
        for key, value in p1.items():
            print("Value is ====>" + str(value))
            print(key)
            if type(value) is dict:
                print("Calling parse func dict inside dict")
                arr.append(key)
                print(arr)
                parse_exp(value)
                if len(arr) != 0:
                    arr.pop()
            elif type(value) is list:
                print("Calling parse func list inside dict")
                index_list = 0
                print("Inside list func2" + str(p1))
                for item in value:
                    print("ITEM LIST is" + str(item))
                    k1 = key + '[' + str(index_list) + ']'
                    print(k1)
                    arr.append(k1)
                    print("Arr is" + str(arr))
                    parse_exp(item)
                    print("Return to list ")
                    index_list = index_list + 1
                    if len(arr) != 0:
                        print("Popping!!! last value from list inside dict arr " + str(arr))
                        arr.pop()
                        print("After poppingg!!! " + str(arr))

            else:
                print("Calling parse func inside dict")
                print("Else of dict ")
                arr.append(key)
                print(arr)
                global str1
                str1 = ''
                length = len(arr)
                print("Length of arr is " + str(length))
                for ind in range(length):
                    print("Index is " + str(ind))
                    if ind != 0 and ind != length - 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        elatind2 = arr[ind + 1]
                        str1 = str1 + str(elatind)
                        if not (elatind2.startswith('[') and elatind.startswith('[')):
                            str1 = str1 + '.'
                    elif ind == 0 and length != 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        elatind2 = arr[ind + 1]
                        str1 = str1 + str(elatind)
                        if not (elatind2.startswith('[') and elatind.startswith('[')):
                            str1 = str1 + '.'
                    elif ind == 0 and length == 1:
                        elatind = arr[ind]
                        str1 = str1 + str(elatind)
                    elif ind == length - 1:
                        print(arr[ind])
                        elatind = arr[ind]
                        str1 = str1 + str(elatind)
                    print("str1 is " + str1)
                key1 = jmespath.search(str1, response_dict)
                print("value from response dict is " + str(key1))
                key2 = jmespath.search(str1, response_sample_dict)
                print("value from sample dict is " + str(key2))
                if str(key2) != 'undefined':
                    if str(key2) != str(key1):
                        print("key values are not equal for key " + str(str1))
                        flag = 0
                        print("Flag is" + str(flag))
                    else:
                        print("key values are equal for key " + str(str1))
                else:
                    print("Not comparing since value is undefined")
                str1 = ''

                if len(arr) != 0:
                    lastkey = arr[len(arr) - 1]
                    print(lastkey)
                    if '[' not in lastkey:
                        print("Popping!!! last value from arr " + str(arr))
                        arr.pop()
                        print("After poppingg!!! " + str(arr))

    elif type(p1) is list:
        print("Calling parse func inside list")
        index_list = 0
        key = ''
        print("Inside list func3")
        for item in p1:
            k1 = key + '[' + str(index_list) + ']'
            print(k1)
            arr.append(k1)

            print("Item " + str(item))
            parse_exp(item)

            index_list = index_list + 1
            if len(arr) != 0:
                print("Popping!!! last value from parse arr " + str(arr))
                arr.pop()
                print("After poppingg!!! " + str(arr))
    else:
        print("Calling parse func no dict")
        str1 = ''
        length = len(arr)
        for ind in range(length):
            print("Index is " + str(ind))
            if ind != 0 and ind != length - 1:
                print(arr[ind])
                elatind = arr[ind]
                elatind2 = arr[ind + 1]
                str1 = str1 + str(elatind)
                if not (elatind2.startswith('[') and elatind.startswith('[')):
                    str1 = str1 + '.'
            elif ind == 0 and length != 1:
                print(arr[ind])
                elatind = arr[ind]
                elatind2 = arr[ind + 1]
                str1 = str1 + str(elatind)
                if not (elatind2.startswith('[') and elatind.startswith('[')):
                    str1 = str1 + '.'
            elif ind == 0 and length == 1:
                elatind = arr[ind]
                str1 = str1 + str(elatind)
            elif ind == length - 1:
                print(arr[ind])
                elatind = arr[ind]
                str1 = str1 + str(elatind)
            print("str1 is " + str1)
        key1 = jmespath.search(str1, response_dict)
        print("Value from response dict is " + str(key1))
        key2 = jmespath.search(str1, response_sample_dict)
        print("value from sample dict is " + str(key2))
        if str(key2) != 'undefined':
            if str(key2) != str(key1):
                print("key values are not equal for key " + str(str1))
                flag = 0
                print("Flag is" + str(flag))
            else:
                print("key values are equal for key " + str(str1))
        else:
            print("Not comparing since value is undefined")
        str1 = ''
        if len(arr) != 0:
            lastkey = arr[len(arr) - 1]
            print(lastkey)
            if '[' not in lastkey:
                print("Popping!!! last value from arr " + str(arr))
                arr.pop()
                print("After poppingg!!! " + str(arr))


def api_response_validation(response_di, response_sample_di):
    global response_dict, response_sample_dict, flag_list
    response_dict = response_di
    response_sample_dict = response_sample_di
    global flag
    flag = 1
    if type(response_sample_di) is dict:
        print("Success")
    print("Calling parse func")
    parse_exp(response_sample_dict)
    while len(arr) != 0:
        arr.pop()
    print("Flag is" + str(flag))
    if flag == 0:
        print("FAIL")
    return flag


def flatten(input_dict, separator='_', prefix=''):
    output_dict = {}
    if type(input_dict) is dict:
        for key, value in input_dict.items():
            if isinstance(value, dict) and value:
                deeper = flatten(value, separator, prefix + key + separator)
                output_dict.update({key2: val2 for key2, val2 in deeper.items()})
            elif isinstance(value, list) and value:
                for index, sublist in enumerate(value, start=1):
                    if isinstance(sublist, dict) and sublist:
                        deeper = flatten(sublist, separator, prefix + key + separator + str(index) + separator)
                        output_dict.update({key2: val2 for key2, val2 in deeper.items()})
                    else:
                        output_dict[prefix + key + separator + str(index)] = value
            else:
                output_dict[prefix + key] = value
    elif type(input_dict) is list:
        for index, sublist in enumerate(input_dict, start=1):
            if isinstance(sublist, dict) and sublist:
                deeper = flatten(sublist, separator, prefix + separator + str(index) + separator)
                output_dict.update({key2: val2 for key2, val2 in deeper.items()})
    return output_dict


def api_key_validation(response_di, response_sample_di):
    # This function is used to validate if the keys in json response received from REST API and the sample response are same
    # It takes 2 arguments. First one is the json.response and second is the sample response
    global flag
    flag = 1
    global response_dict, response_sample_dict
    response_dict = response_di
    response_sample_dict = response_sample_di
    out = flatten(response_dict)
    print("Flattened response dictionary is " + str(out))
    out1 = flatten(response_sample_dict)
    print("Flattened response dictionary is " + str(out1))

    out_len = len(out.keys())
    out1_len = len(out1.keys())
    print("Length of response dict is " + str(out_len))
    print("Length of sample response dict is " + str(out1_len))

    if out_len != out1_len:
        flag = 0

    list1_response = []
    list2_sample_response = []
    for key in out.keys():
        list1_response.append(key)

    for key in out1.keys():
        list2_sample_response.append(key)

    list1_response.sort()
    list2_sample_response.sort()
    print("Response key list is " + str(list1_response))
    print("Response sample key list is " + str(list2_sample_response))
    if list1_response != list2_sample_response:
        print("Key validation failed")
        flag = 0

    print("Flag is " + str(flag))
    return flag


def validateJson(jsonData, tokenSchema):
    error = validate(jsonData, tokenSchema)
    print(error)
    print("Error observed during API Schema Validation in json payload validator : " + str(error))
    if error != None:
        return error
    else:
        return True
    error1 = jsonschema.validate(instance=jsonData, schema=tokenSchema)
    print(error1)
    print("Error observed during API Schema Validation in jsonschema : " + str(error1))
    if error1 != None:
        return error1
    else:
        return True


def api_schema_validation(jsonData, tokenSchema):
    if type(jsonData) is list:
        jsonData1 = jsonData
    elif type(jsonData) is dict:
        jsonData1 = jsonData
    else:
        jsonData1 = json.loads(jsonData)
    isValid = validateJson(jsonData1, tokenSchema)
    print("API Schema Valid Parameter is " + str(isValid))
    if isValid == True:
        print(jsonData1)
        print("Given JSON data is Valid")
        return True
    else:
        print(jsonData1)
        print("Given JSON data is InValid")
        return False


def json_order(element):
    if isinstance(element, dict):
        return sorted((key, json_order(value)) for key, value in element.items())
    if isinstance(element, list):
        return sorted(json_order(a) for a in element)
    else:
        return element






