## User 'cedar' has read access to several graphs.
DB.DBA.USER_CREATE ('cedar', sprintf('%d',rnd(1e16)));
GRANT SPARQL_SELECT to "cedar";
DB.DBA.RDF_DEFAULT_USER_PERMS_SET ('cedar', 0);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://lod.cedar-project.nl/resource/BRT_1889_08_T1', 'cedar', 1);
DB.DBA.RDF_GRAPH_USER_PERMS_SET ('http://lod.cedar-project.nl/resource/BRT_1899_04_T', 'cedar', 1);

## Endpoint /sparql/cedar uses credentials of user 'cedar'
DB.DBA.VHOST_REMOVE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/cedar'
);
DB.DBA.VHOST_DEFINE (
	 lhost=>'*ini*',
	 vhost=>'*ini*',
	 lpath=>'/sparql/cedar',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 def_page=>'',
	 sec=>'basic',
	 realm=>'cedar',
	 auth_fn=>'DB.DBA.HP_AUTH_SQL_USER_AUTO',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes', 'cors', '*', 'cors_restricted', 0),
	 is_default_host=>0
);
