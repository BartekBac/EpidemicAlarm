import random

f_res = open('../result/inserts-zone.sql', 'w', encoding="utf8")

s_insert = """insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id, city, region, subregion)
values (8, '2021-4-26', 10, '2021-7-25', 50.11191704460362, 18.790735011176114, 0, 8, 2, 2, 'Orzesze', 'śląskie', 'mikołowski');"""

s_insert_pre = """insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id, city, region, subregion)
values ("""
s_insert_mid = """, '2021-4-26', 10, '2021-7-25', """
# 50.293911347201565, 18.665461537501564
s_insert_post = """, 0, 8, 2, 2, '', '', '');
"""

indx = 4000

lat_c = 50.293911347201565
lng_c = 18.665461537501564

for ins in range(25):
    lat_r = random.triangular(-0.01, 0.01)
    lng_r = random.triangular(-0.01, 0.01)
    indx += 1
    s_ins = s_insert_pre + str(indx) + s_insert_mid + str(lat_c + lat_r) +", " + str(lng_c + lng_r) + s_insert_post
    #print(s_ins)
    f_res.write(s_ins)

f_res.close()