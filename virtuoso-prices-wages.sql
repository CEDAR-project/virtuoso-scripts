## User 'prices-wages' has read access to several graphs.
DB.DBA.USER_CREATE ('prices-wages', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "prices-wages";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('prices-wages', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:prices-wages:raw-data', 'prices-wages', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:prices-wages:rules', 'prices-wages', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:prices-wages:release', 'prices-wages', 1);

## Endpoint /sparql/semstats uses credentials of user 'prices-wages'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/prices-wages/sparql'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/prices-wages/sparql',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'prices-wages',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
