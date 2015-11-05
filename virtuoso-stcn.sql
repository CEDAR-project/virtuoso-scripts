## User 'stcns' has read access to several graphs.
DB.DBA.USER_CREATE ('stcn', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "stcn";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('stcn', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://stcn.data2semantics.org', 'stcn', 1);

## Endpoint /sparql/semstats uses credentials of user 'stcn'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/stcn'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/stcn',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'stcn',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
