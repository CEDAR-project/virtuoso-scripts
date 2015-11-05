## User 'atles' has read access to several graphs.
DB.DBA.USER_CREATE ('atles', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "atles";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('atles', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://example.org/atles', 'atles', 1);

## Endpoint /sparql/semstats uses credentials of user 'atles'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/atles'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/atles',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'atles',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
