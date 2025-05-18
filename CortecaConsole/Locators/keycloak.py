# single device
import json
submit_provision="xpath=(//button[contains(@type,'submit')])[1]"
networkmac="xpath=(//input[contains(@class,'pv-input large')])[1]"
netpass="xpath=(//input[contains(@class,'pv-input large')])[2]"

# multiple device




# validate provision
netvalidate="xpath=//button[@type='submit'][contains(.,'Validate')]"
valmac="xpath=(//input[contains(@class,'pv-input large')])[6]"
valpass="xpath=(//input[contains(@class,'pv-input large')])[7]"



# Delete provision
delmac="xpath=(//input[contains(@class,'pv-input large')])[8]"
deletebutton="xpath=//button[@type='submit'][contains(.,'Delete')]"

# bulk delete
choosefiledel="xpath=(//span[@class='p-button-label'][contains(.,'Choose File')])[2]"
uploaddeletion="xpath=(//span[@class='p-button-label ng-star-inserted'][contains(.,'Upload')])[2]"


# bulkprov
choosefileprov="xpath=(//span[@class='p-button-label'][contains(.,'Choose File')])[1]"
uploadprov="xpath=(//span[@class='p-button-label ng-star-inserted'][contains(.,'Upload')])[1]"



# Deployment report

# NDA
ndmac="xpath=(//input[contains(@type,'text')])[2]"
ndcust="xpath=(//input[contains(@type,'text')])[1]"
submit1="xpath=(//button[@type='submit'][contains(.,'Submit')])[1]"

# UNDA
newcust="xpath=(//input[contains(@type,'text')])[6]"
oldcust="xpath=(//input[contains(@type,'text')])[5]"
submit2="xpath=(//button[@type='submit'][contains(.,'Submit')])[2]"

# validate
valcust="xpath=(//input[contains(@type,'text')])[9]"
delupload="xpath=//span[@class='p-button-label ng-star-inserted'][contains(.,'Upload')]"
validate1="xpath=(//button[@type='submit'][contains(.,'Validate')])[1]"
delcust="xpath=(//input[contains(@type,'text')])[13]"
dele1="xpath=(//button[@type='submit'][contains(.,'Validate')])[1]"
select4="xpath=(//li[contains(@id,'4')])[1]"


applications=['Nokia Packet Capture','Nokia Fingerprint','Nokia Home Device Manager','Blocky','F-Secure Sense','Nokia Broadband Compliance','M-Lab Speed Test']
abc={
  "username": "string", \
  "password": "string", \
  "oui": "string", \
  "pc": "string", \
  "sn": "string"
}

# FCC
namefcc="xpath=(//input[contains(@type,'text')])[2]"
cron="xpath=(//input[contains(@type,'text')])[3]"
selecthour="xpath=(//div[contains(@class,'p-multiselect-label')])[2]"

upstream="xpath=(//input[contains(@role,'spinbutton')])[1]"
downstream="xpath=(//input[contains(@role,'spinbutton')])[2]"
inputlatency="xpath=//span[@class='ng-star-inserted'][contains(.,'Latency')]"

#keycloak tenant3
searchuser="xpath=//input[contains(@type,'text')]"






