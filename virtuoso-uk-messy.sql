## User 'uk-messy' has read access to several graphs.
DB.DBA.USER_CREATE ('uk-messy', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "uk-messy";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('uk-messy', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:uk-messy:raw-data', 'uk-messy', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:uk-messy:rules', 'uk-messy', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:uk-messy:release', 'uk-messy', 1);

## Endpoint /sparql/uk-messy uses credentials of user 'uk-messy'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/uk-messy/sparql'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/uk-messy/sparql',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'uk-messy',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
