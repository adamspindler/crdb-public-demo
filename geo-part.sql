alter table mr.global_parent configure zone using num_replicas = 9, num_voters = 3;

alter table mr.eu_parent configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=emea]';

alter table mr.eu_child configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=emea]';

alter table mr.eu_multi_a configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=emea]';

alter table mr.eu_multi_b configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=emea]';

alter table mr.eu_m2m configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[+region=emea]';

alter table mr.us_parent configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[-region=namr]';

alter table mr.us_child configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[-region=namr]';

alter table mr.us_multi_a configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[-region=namr]';

alter table mr.us_multi_b configure zone using num_replicas = 4, constraints = '{"+region=namr": 2, "+region=apac": 2}', num_voters=3, voter_constraints = '{"+region=namr": 1, "+region=apac": 1}';

alter table mr.us_m2m configure zone using num_replicas=3, gc.ttlseconds=90000, constraints = '[-region=namr]';

ALTER TABLE mr.global_child PARTITION BY LIST (city) (
PARTITION us VALUES IN ('seattle','san francisco','los angeles','phoenix','minneapolis',
'chicago','detroit','atlanta','new york','boston','washington dc','miami'),
PARTITION eu VALUES IN ('london', 'leinster','munster','connacht','ulster', 'frankfurt','amsterdam','milano','madrid','athens','barcelona','stockholm','helsinki','oslo','paris', 'munich', 'koln', 'dortmund', 'stuttgart'),
PARTITION apac VALUES IN ('singapore', 'tokyo', 'seoul', 'hong kong', 'beijing', 'bangkok', 'sydney', 'shanghai', 'melbourne'),
PARTITION ru VALUES IN ('moscow', 'st petersburg'),
PARTITION DEFAULT VALUES IN (DEFAULT)
);

ALTER PARTITION us OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=namr]';

ALTER PARTITION eu OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=emea]';

ALTER PARTITION apac OF TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[+region=apac]';

ALTER PARTITION ru of TABLE mr.global_child CONFIGURE ZONE USING num_replicas=3, constraints='[-region=namr]';
