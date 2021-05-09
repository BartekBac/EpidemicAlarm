insert into address (id, house_number, zip_code, city, street)
values (0, '3', '43-170', 'Łaziska Górne', 'Powstańców');
insert into address (id, house_number, zip_code, city, street)
values (1, '35', '43-170', 'Łaziska Górne', 'Dworcowa');
insert into address (id, house_number, zip_code, city, street)
values (2, '15', '43-170', 'Łaziska Górne', 'Słoneczna');
insert into address (id, house_number, zip_code, city, street)
values (3, '32', '43-190', 'Mikołów', 'Żwirki i Wigury');
insert into address (id, house_number, zip_code, city, street)
values (4, '12', '43-190', 'Mikołów', 'Damrota');
insert into address (id, house_number, zip_code, city, street)
values (5, '4', '43-190', 'Mikołów', 'Konwalii');
insert into address (id, house_number, zip_code, city, street)
values (6, '63', '43-190', 'Mikołów', 'Rybnicka');
insert into address (id, house_number, zip_code, city, street)
values (7, '11', '43-180', 'Orzesze', 'Żorska');
insert into address (id, house_number, zip_code, city, street)
values (8, '5', '43-188', 'Orzesze', 'Lipowa');
insert into address (id, house_number, zip_code, city, street)
values (9, '17', '43-180', 'Orzesze', 'Wojska Polskiego');
insert into address (id, house_number, zip_code, city, street)
values (10, '2', '44-237', 'Bełk', 'Karola Miarki');
insert into address (id, house_number, zip_code, city, street)
values (11, '52', '43-180', 'Orzesze', 'Katowicka');
insert into institution (id, location_lat, location_lng, name, address_id)
values (0, 50.17133374812808, 18.87809824990311, 'Mikołowski Ośrodek Zdrowia', 6);
insert into institution (id, location_lat, location_lng, name, address_id)
values (1, 50.13934587759751, 18.866713168849312, 'Przychodnia Łaziska Średnie', 0);
insert into institution (id, location_lat, location_lng, name, address_id)
values (2, 50.138037599571234, 18.76726351302928, 'Miejski Ośrodek Zdrowia Orzesze', 7);
insert into data_administrator (id, login, password, institution_id)
values (0, 'admin0', 'admin0', 1);
insert into data_administrator (id, login, password, institution_id)
values (1, 'admin1', 'admin1', 0);
insert into data_administrator (id, login, password, institution_id)
values (2, 'admin2', 'admin2', 2);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (0, 'szczepan11@gmail.com', 'Szczepan', 'Oleksy', '68112709118', '505102113', 2);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (0, '2021-4-22', 10, '2021-5-04', 50.126679530352924, 18.8714986823408, 0, 0, 1, 0);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (1, 'marpan82401@gmail.com', 'Marek', 'Panewnicki', '72032118002', '66812045', 1);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (1, '2021-4-23', 10, '2021-5-05', 50.153622542710416, 18.842734584193984, 0, 1, 1, 0);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (2, 'bibi213@vp.pl', 'Martyna', 'Krzak', '92030356489', '551236546', 3);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (2, '2021-4-24', 10, '2021-5-06', 50.168968188871176, 18.892023240014627, 0, 2, 0, 1);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (3, 'wolfik62@wp.pl', 'Tomasz', 'Wilk', '62061516513', '684123586', 4);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (3, '2021-4-25', 10, '2021-5-07', 50.16145450399586, 18.88813184001431, 0, 3, 0, 1);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (4, 'juleczka.orteza@wp.pl', 'Julia', 'Orteza', '77122903626', '721564223', 5);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (4, '2021-4-26', 10, '2021-5-08', 50.16763945305906, 18.890472153506487, 0, 4, 0, 1);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (5, 'boss_big_brain@gmail.pl', 'Daniel', 'Tam', '96051200365', '566893214', 8);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (5, '2021-4-27', 10, '2021-5-09', 50.11269492290502, 18.758556126520165, 0, 5, 2, 2);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (6, 'marta.max12@op.pl', 'Marta', 'Bolek', '95101726553', '667952147', 9);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (6, '2021-4-27', 10, '2021-5-09', 50.112550523278415, 18.77928461117616, 0, 6, 2, 2);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (7, 'panpawel@op.pl', 'Paweł', 'Szmula', '63121203564', '756885213', 10);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (7, '2021-4-28', 10, '2021-5-10', 50.136641644779566, 18.72259131117724, 0, 7, 2, 2);
insert into identity (id, email, first_name, last_name, personal_id, phone_number, address_id)
values (8, 'zibi12@wp.pl', 'Zbigniew', 'Skoczek', '56031622135', '605231668', 11);
insert into diagnosed_case (id, diagnosis_date, duration, expiration_date, location_lat, location_lng, status,
                            identity_id, institution_id, data_administrator_id)
values (8, '2021-4-26', 10, '2021-5-08', 50.11191704460362, 18.790735011176114, 0, 8, 2, 2);
