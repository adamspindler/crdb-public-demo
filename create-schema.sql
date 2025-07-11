drop database if exists ajs cascade;

create database ajs;

use ajs;

use ajs;

create table ajs.us_parent(id UUID primary key default gen_random_uuid()
	                   ,value string);

create table ajs.us_child(id UUID primary key default gen_random_uuid()
	                  ,parent_id UUID references ajs.us_parent(id) on delete cascade
			  ,value string);

create table ajs.us_multi_a(id UUID primary key default gen_random_uuid()
	                    ,value string);

create table ajs.us_multi_b(id UUID primary key default gen_random_uuid()
	                    ,value string);

create table ajs.us_m2m(id UUID primary key default gen_random_uuid()
	                ,a_id UUID references ajs.us_multi_a(id) on delete cascade
	                ,b_id UUID references ajs.us_multi_b(id) on delete cascade
			,value string);

create table ajs.eu_parent(id UUID primary key default gen_random_uuid()
	                   ,value string);

create table ajs.eu_child(id UUID primary key default gen_random_uuid()
	                  ,parent_id UUID references ajs.eu_parent(id) on delete cascade
			  ,value string);

create table ajs.eu_multi_a(id UUID primary key default gen_random_uuid()
	                    ,value string);

create table ajs.eu_multi_b(id UUID primary key default gen_random_uuid()
	                    ,value string);

create table ajs.eu_m2m(id UUID primary key default gen_random_uuid()
	                ,a_id UUID references ajs.eu_multi_a(id) on delete cascade
	                ,b_id UUID references ajs.eu_multi_b(id) on delete cascade
			,value string);

create table ajs.global_parent(id UUID primary key default gen_random_uuid()
	                   ,value string);

create table ajs.global_child(id UUID default gen_random_uuid()
	                  ,city string
	                  ,parent_id UUID references ajs.global_parent(id) on delete cascade
			  ,value string
		          ,constraint "primary" primary key (city, id));

insert into ajs.eu_parent (value) 
                    values ('one'),('two'),('three'),('four'),('five');
                                          

insert into ajs.eu_child (parent_id, value) SELECT id, 'a' from eu_parent where value = 'one';
insert into ajs.eu_child (parent_id, value) SELECT id, 'b' from eu_parent where value = 'one';
insert into ajs.eu_child (parent_id, value) SELECT id, 'c' from eu_parent where value = 'two';
insert into ajs.eu_child (parent_id, value) SELECT id, 'd' from eu_parent where value = 'two';
insert into ajs.eu_child (parent_id, value) SELECT id, 'e' from eu_parent where value = 'three';
insert into ajs.eu_child (parent_id, value) SELECT id, 'f' from eu_parent where value = 'three';
insert into ajs.eu_child (parent_id, value) SELECT id, 'g' from eu_parent where value = 'four';
insert into ajs.eu_child (parent_id, value) SELECT id, 'h' from eu_parent where value = 'four';
insert into ajs.eu_child (parent_id, value) SELECT id, 'i' from eu_parent where value = 'five';
insert into ajs.eu_child (parent_id, value) SELECT id, 'j' from eu_parent where value = 'five';


insert into ajs.eu_multi_a (value) 
                    values ('alpha'),('beta');

insert into ajs.eu_multi_b (value) 
                    values ('red'),('green');

insert into ajs.eu_m2m (a_id, b_id, value) select ajs.eu_multi_a.id, ajs.eu_multi_b.id, 'link' from ajs.eu_multi_a, ajs.eu_multi_b;


insert into ajs.us_parent (value) 
                    values ('North'),('South'),('East'),('West');
                                          
insert into ajs.us_child (parent_id, value) SELECT id, 'k' from us_parent where value = 'North';
insert into ajs.us_child (parent_id, value) SELECT id, 'l' from us_parent where value = 'North';
insert into ajs.us_child (parent_id, value) SELECT id, 'm' from us_parent where value = 'South';
insert into ajs.us_child (parent_id, value) SELECT id, 'n' from us_parent where value = 'South';
insert into ajs.us_child (parent_id, value) SELECT id, 'o' from us_parent where value = 'East';
insert into ajs.us_child (parent_id, value) SELECT id, 'p' from us_parent where value = 'East';
insert into ajs.us_child (parent_id, value) SELECT id, 'q' from us_parent where value = 'West';
insert into ajs.us_child (parent_id, value) SELECT id, 'r' from us_parent where value = 'West';
insert into ajs.us_child (parent_id, value) SELECT id, 's' from us_parent where value = 'South';
insert into ajs.us_child (parent_id, value) SELECT id, 't' from us_parent where value = 'South';


insert into ajs.us_multi_a (value) 
                    values ('Achilles'),('Hector');
                                          
insert into ajs.us_multi_b (value) 
                    values ('Priam'),('Odysseus');

insert into ajs.us_m2m (a_id, b_id, value) select ajs.us_multi_a.id, ajs.us_multi_b.id, 'link2' from ajs.us_multi_a, ajs.us_multi_b;
                                          


insert into ajs.global_parent (value) 
                    values ('Rugby'),('Baseball'),('American Football'),('Athletics'),('Football');

insert into ajs.global_child (city, parent_id, value) SELECT 'london', id, 'Quins' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'london', id, 'Irish' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'london', id, 'Saracens' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'boston', id, 'Patriots' from global_parent where value = 'American Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'london', id, 'Monarchs' from global_parent where value = 'American Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'miami', id, 'Dolphins' from global_parent where value = 'American Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'los angeles', id, 'Raiders' from global_parent where value = 'American Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'chicago', id, 'Bears' from global_parent where value = 'American Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'leinster', id, 'Leinster' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'munster', id, 'Munster' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'ulster', id, 'Ulster' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'connacht', id, 'Connacht' from global_parent where value = 'Rugby';
insert into ajs.global_child (city, parent_id, value) SELECT 'munich', id, 'FC Bayern Munich' from global_parent where value = 'Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'koln', id, 'FC Koln' from global_parent where value = 'Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'dortmund', id, 'Borussia Dortmund' from global_parent where value = 'Football';
insert into ajs.global_child (city, parent_id, value) SELECT 'stuttgart', id, 'VfB Stuttgart' from global_parent where value = 'Football';

create table if not exists enc_test(enc_id uuid primary key default gen_random_uuid()
                                   ,name string
                                   ,cyphertext bytes
                                   ,cyphertext_iv bytes);

WITH
    iv AS (SELECT gen_random_bytes(16) AS iv)
INSERT
INTO
    enc_test (name, cyphertext, cyphertext_iv)
SELECT
    'Jane Doe',
    encrypt_iv(
        'NI Number: [String of characters]'::BYTES,
        'your_secret_key'::BYTES,
        iv,
        'aes'
    ),
    iv
FROM
    iv;

create type if not exists longlat as (long float, lat float);

create table if not exists postcodes (outcode string
                                     ,incode string
                                     ,long float
                                     ,lat float
                                     ,constraint postcodes_pk primary key (outcode, incode)); 

insert into postcodes (outcode, incode, long, lat) values ('SW1A', '1AA', -0.141588, 51.501009)
                                                         ,('EC1A', '1BB', -0.097386, 51.520487)
                                                         ,('W1A',  '1AA', -0.139666, 51.515261)
                                                         ,('N1',   '9GU', -0.121093, 51.532456)
                                                         ,('SE1',  '7PB', -0.116710, 51.504530)
                                                         ,('B1',   '1AA', -1.901805, 52.478709)
                                                         ,('M1',   '1AA', -2.236657, 53.479489)
                                                         ,('LS1',  '1AA', -1.542349, 53.797152)
                                                         ,('G1',   '1AA', -4.252155, 55.860916)
                                                         ,('EH1',  '1BB', -3.190918, 55.952447);

CREATE OR REPLACE FUNCTION getlonglat(in p_outcode string, in p_incode string) RETURNS longlat language PLpgSQL AS $$ 
DECLARE
   v_longlat longlat;
   v_long float;
   v_lat float;
BEGIN
   select long
         ,lat
     from postcodes 
    where postcodes.outcode = p_outcode 
      and postcodes.incode = p_incode 
     into v_long, v_lat;
   v_longlat = (v_long, v_lat);
   return v_longlat;
END
$$;

create or replace procedure tmptest(inout p_outcode string, inout p_incode string) language PLpgSQL AS $$ 
DECLARE
   v_longlat longlat;
   v_long float;
   v_lat float;
begin
   v_longlat := getlonglat(p_outcode, p_incode);
   v_long := (v_longlat).long;
   raise notice 'v_long: %', v_long;
   v_lat := (v_longlat).lat;
   raise notice 'v_lat: %', v_lat;
end
$$;
