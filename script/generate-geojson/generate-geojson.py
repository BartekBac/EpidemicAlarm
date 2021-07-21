import json

# Name parsers
def parsePowName(name):
    return name.replace("Powiat m.", "").replace("Powiat ", "")

def parseWojName(name):
    return name.lower()

def parseGPowName(name):
    return name.replace("powiat ", "")

powIgnoreNames = ["Powiat m.Wałbrzych do 2002", "Powiat warszawski"]
  
# Opening JSON files

f_woj = open('../data/bdl-woj.json', encoding="utf8")
f_pow = open('../data/bdl-pow.json', encoding="utf8")
fg_woj = open('../data/wojewodztwa-min.geojson', encoding="utf8")
fg_pow = open('../data/powiaty-min.geojson', encoding="utf8")
  
# returns JSON object as a dictionary
json_woj = json.load(f_woj)
json_pow = json.load(f_pow)
gjson_woj = json.load(fg_woj)
gjson_pow = json.load(fg_pow)
data_woj = json_woj['results']
data_pow = json_pow['results']
  
# remove unnecessary
for pow in data_pow:
    pow['name'] = parsePowName(pow['name'])
    if pow['name'] == 'warszawski' or pow['name'] == "Wałbrzych do 2002":
        data_pow.remove(pow)
    #print(parsePowName(pow['name']) + " ("+pow['id']+" :: "+pow['parentId'])

for woj in data_woj:
#    print(parseWojName("START # " + woj['name'] + "[ID=" + woj['id']+"]"))
    n = 0
    for pow in data_pow:
        if(pow['parentId'][0:4] == woj['id'][0:4]):
            pow['parentName']=parseWojName(woj['name'])
            n += 1
            #print("  " + parsePowName(pow['name']) + " [PARENT_ID="+pow['parentId']+", ID="+pow['id']+"]")
#    print(parseWojName("STOP # " + woj['name'] + "[ID=" + woj['id']+"] N = "+str(n)))

# check read data cohesion
print("Fetched woj counts:")
print(str(len(data_woj))+" == "+str(len(gjson_woj['features'])))
print("Fetched pow counts:")
print(str(len(data_pow))+" == "+str(len(gjson_pow['features'])))

# rewrite "woj" geojson
for gwoj in gjson_woj['features']:
    gwojName=gwoj['properties']['nazwa']
    gwojId = 0
    try:
        gwojId = str(gwoj['properties']['id'])
    except:
        gwojId = gwoj['properties']['id']

    wojs = [woj for woj in data_woj if woj['name'].lower() == gwojName]
    for woj in wojs:
        gwoj['properties']={"id": int(gwojId), "name": gwojName, "level": 2, "bdlId": woj['id']}

with open('woj.geojson', 'w', encoding='utf-8') as fp:
    json.dump(gjson_woj, fp, ensure_ascii=False)

# rewrite "pow" geojson
skipCounter = 0
expectedSkips = 18
fromId = 16
for gpow in gjson_pow['features']:
    gpowName=parseGPowName(gpow['properties']['nazwa'])
    gpow['id']=fromId
    fromId += 1
    gpowId = 0
    try:
        gpowId = str(gpow['properties']['id'])
    except:
        gpowId = gpow['properties']['id']

    pows = [pow for pow in data_pow if pow['name'] == gpowName]
    second = False
    for pow in pows:
        if gpowId == "79" and pow['parentName'] == "śląskie":
            skipCounter += 1
        elif gpowId == "270" and pow['parentName'] == "podlaskie":
            skipCounter += 1
        elif gpowId == "18" and pow['parentName'] == "małopolskie":
            skipCounter += 1
        elif gpowId == "13" and pow['parentName'] == "opolskie":
            skipCounter += 1
        elif gpowId == "182" and pow['parentName'] == "mazowieckie":
            skipCounter += 1
        elif gpowId == "9" and pow['parentName'] == "wielkopolskie":
            skipCounter += 1
        elif gpowId == "165" and pow['parentName'] == "pomorskie":
            skipCounter += 1
        elif gpowId == "377" and pow['parentName'] == "mazowieckie":
            skipCounter += 1
        elif gpowId == "333" and pow['parentName'] == "lubelskie":
            skipCounter += 1
        elif gpowId == "126" and pow['parentName'] == "opolskie":
            skipCounter += 1
        elif gpowId == "112" and pow['parentName'] == "wielkopolskie":
            skipCounter += 1
        elif gpowId == "214" and pow['parentName'] == "mazowieckie":
            skipCounter += 1
        elif gpowId == "367" and pow['parentName'] == "wielkopolskie":
            skipCounter += 1
        elif gpowId == "57" and pow['parentName'] == "dolnośląskie":
            skipCounter += 1
        elif gpowId == "211" and pow['parentName'] == "lubelskie":
            skipCounter += 1
        elif gpowId == "173" and pow['parentName'] == "dolnośląskie":
            skipCounter += 1
        elif gpowId == "11" and pow['parentName'] == "łódzkie":
            skipCounter += 1
        elif gpowId == "282" and pow['parentName'] == "lubelskie":
            skipCounter += 1
        else:
            gpow['properties']={"id": int(gpowId), "name": gpowName, "level": 5, "bdlId": pow['id'], "bdlName": pow['name'], "bdlParentId": pow['parentId'], "bdlParentName": pow['parentName']}
            #print(gpow['properties'])

with open('../result/polygons.geojson', 'w', encoding='utf-8') as fp:
    json.dump(gjson_pow, fp, ensure_ascii=False)

# check skipped rows
print("Skupped rows:")
print(str(skipCounter)+" == "+str(expectedSkips))

# Closing file
f_woj.close()
f_pow.close()

print("Done.")

### doubled pow names assigned to woj ###
# pow_name      pow_id  woj_name  
# bielski       79      podlaskie
# bielski       270     śląskie
# brzeski       18      opolskie
# brzeski       13      małopolskie
# grodziski     182     wielkopolskie
# grodziski     9       mazowieckie
# nowodworski   165     mazowieckie
# nowodworski   377     pomorskie
# opolski       333     opolskie
# opolski       126     lubelskie
# ostrowski     112     mazowieckie
# ostrowski     214     wielkopolskie
# średzki       367     dolnośląskie
# średzki       57      wielkopolskie
# świdnicki     211     dolnośląskie
# świdnicki     173     lubelskie
# tomaszowski   11      lubelskie
# tomaszowski   282     łódzkie