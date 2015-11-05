## User 'dbpedia-v' has read access to several graphs.
DB.DBA.USER_CREATE ('dbpedia-v', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "dbpedia-v";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('dbpedia-v', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://dbpedia.org/3.9/categories', 'dbpedia-v', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://dbpedia.org/3.9/article-categories', 'dbpedia-v', 1);

## Endpoint /sparql/cedar uses credentials of user 'dbpedia-v'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/dbpedia-v'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/dbpedia-v',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'dbpedia-v',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
