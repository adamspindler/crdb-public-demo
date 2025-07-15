alter table mr.global_parent configure zone using num_replicas = 9, num_voters = 3;

alter table mr.eu_parent configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=EMEA]';

alter table mr.eu_child configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=EMEA]';

alter table mr.eu_multi_a configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=EMEA]';

alter table mr.eu_multi_b configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=EMEA]';

alter table mr.eu_m2m configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=EMEA]';

alter table mr.us_parent configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=NAMR]';

alter table mr.us_child configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=NAMR]';

alter table mr.us_multi_a configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=NAMR]';

alter table mr.us_multi_b configure zone using num_replicas = 4, constraints = '{"+region=NAMR": 2, "+region=APAC": 2}', num_voters=3, voter_constraints = '{"+region=NAMR": 1, "+region=APAC": 1}';

alter table mr.us_m2m configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=NAMR]';

ALTER TABLE mr.global_child PARTITION BY LIST (city) (
PARTITION us VALUES IN ('seattle','san francisco','los angeles','phoenix','minneapolis',
'chicago','detroit','atlanta','new york','boston','washington dc','miami'),
PARTITION eu VALUES IN ('london', 'leinster','munster','connacht','ulster', 'frankfurt','amsterdam','milano','madrid','athens','barcelona','stockholm','helsinki','oslo','paris', 'munich', 'koln', 'dortmund', 'stuttgart'),
PARTITION APAC VALUES IN ('singapore', 'tokyo', 'seoul', 'hong kong', 'beijing', 'bangkok', 'sydney', 'shanghai', 'melbourne'),
PARTITION ru VALUES IN ('moscow', 'st petersburg'),
PARTITION DEFAULT VALUES IN (DEFAULT)
);

ALTER PARTITION us OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=NAMR]';

ALTER PARTITION eu OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=EMEA]';

ALTER PARTITION APAC OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=APAC]';

ALTER PARTITION ru of TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[-region=NAMR]';
