## User 'semstats' has read access to several graphs.
DB.DBA.USER_CREATE ('semstats', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "semstats";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('semstats', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://lod.cedar-project.nl/resource/semstats-australia', 'semstats', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://lod.cedar-project.nl/resource/semstats-france', 'semstats', 1);

## Endpoint /sparql/semstats uses credentials of user 'semstats'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/semstats'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/semstats',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'semstats',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
