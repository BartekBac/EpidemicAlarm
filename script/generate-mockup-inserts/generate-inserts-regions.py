import json
import random

def parsePowName(name):
    return name.replace("Powiat m.", "").replace("Powiat ", "")

def parseWojName(name):
    return name.lower()

def parseGPowName(name):
    return name.replace("powiat ", "")

powIgnoreNames = ["Powiat m.Wałbrzych do 2002", "Powiat warszawski"]
  
# Opening JSON file
f_woj = open('../data/bdl-woj.json', encoding="utf8")
f_pow = open('../data/bdl-pow.json', encoding="utf8")
f_res = open('../result/inserts-region.sql', 'w', encoding="utf8")

s_insert = """insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id, city, region, subregion)
values (8, '2021-4-26', 10, '2021-7-25', 50.11191704460362, 18.790735011176114, 0, 8, 2, 2, 'Orzesze', 'śląskie', 'mikołowski');"""

s_insert_pre = """insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id, city, region, subregion)
values ("""
s_insert_mid = """, '2021-4-26', 10, '2021-7-25', 50.11191704460362, 18.790735011176114, 0, 8, 2, 2, '', '"""
# 'śląskie', 'mikołowski'
s_insert_post = """');
"""

# returns JSON object as 
# a dictionary
json_woj = json.load(f_woj)
json_pow = json.load(f_pow)
data_woj = json_woj['results']
data_pow = json_pow['results']

#remove unnecessary
for pow in data_pow:
    pow['name'] = parsePowName(pow['name'])
    if pow['name'] == 'warszawski' or pow['name'] == "Wałbrzych do 2002":
        data_pow.remove(pow)

    #print(parsePowName(pow['name']) + " ("+pow['id']+" :: "+pow['parentId'])


indx = 2000

for woj in data_woj:
    print("START # " + woj['name'] + "[ID=" + woj['id']+"]")
    n = 0
    for pow in data_pow:
        if(pow['parentId'][0:4] == woj['id'][0:4]):
            pow['parentName']=parseWojName(woj['name'])
            n += 1
            r = random.randint(0, 20)
            if(r<14):
                for ins in range(r):
                    indx += 1
                    s_ins = s_insert_pre + str(indx) + s_insert_mid + parseWojName(woj['name']) +"', '" + pow['name'] + s_insert_post
                    #print(s_ins)
                    f_res.write(s_ins)

            #print("  " + parsePowName(pow['name']) + " [PARENT_ID="+pow['parentId']+", ID="+pow['id']+"]")
    print("STOP # " + parseWojName(woj['name']) + "[ID=" + woj['id']+"] N = "+str(n))

print(len(data_woj))
print(len(data_pow))

f_woj.close()
f_pow.close()
f_res.close()