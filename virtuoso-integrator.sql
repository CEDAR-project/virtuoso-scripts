## User 'integrator' has read access to several graphs.
DB.DBA.USER_CREATE ('integrator', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "integrator";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('integrator', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:cedar:raw-rdf', 'integrator', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:cedar:harmonization_rules', 'integrator', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('urn:graph:cedar:harmonised_data', 'integrator', 1);

## Endpoint /sparql/integrator uses credentials of user 'integrator'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/integrator'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/integrator',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'integrator',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
