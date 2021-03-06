class kolab::params (
            $imap_admin_login = "cyrus-admin",
            $imap_admin_password = undef,

            $imap_enable_notify = undef,
            $imap_enable_pop = undef,
            $imap_enable_ptloader = undef,

            $imap_hostname = "$fqdn",
            $imap_port = "993",
            $imap_scheme = "imaps",

            $imap_debug = 0,
            $imap_chatty = 0,
            $imap_auditlog = 0,

            $imap_storage_partitions = [ "default" ],
            $imap_storage_meta_base_path = undef,
            $imap_storage_spool_base_path = "/var/spool/imap",

            $imap_configdir = "/var/lib/imap",
            $imap_duplicate_db_path = undef,
            $imap_ptscache_db_path = undef,
            $imap_sievedir = undef,
            $imap_socket_path = "/var/lib/imap/socket",
            $imap_statuscache_db_path = undef,
            $imap_temp_path = undef,
            $imap_tlscache_db_path = undef,

            # The Kolab version
            $kolab_version_name = 'kolab_14',

            $kolab_primary_domain = "$domain",
            $kolab_default_locale = "en_US",
            $kolab_policy_uid = "%(surname)s.lower()",
            $kolab_freebusy_server = "http://$fqdn/",

            $memcache_hosts = undef,
            $webclient_memcache_hosts = $kolab::params::memcache_hosts,
            $webadmin_memcache_hosts = $kolab::params::memcache_hosts,

            $ldap_scheme = "ldap",
            $ldap_hostname = "$fqdn",
            $ldap_port = "389",
            $ldap_domain_base_dn = "cn=kolab,cn=config",

            $bonnie_api_uri = undef,
            $bonnie_api_webclient_username = 'webclient',
            $bonnie_api_webclient_password = 'Welcome2KolabSystems',
            $bonnie_api_webclient_secret = 'some-md5sum-or-something-le-128-chars',

            $roundcubemail_db_dsnw = "mysqli://roundcube:password@localhost/roundcube",
            $roundcubemail_db_dsnr = undef,

            $smtp_scheme = undef,
            $mynetworks = [ '127.0.0.0/8', '[::1]/128' ],

            $ldap_bind_dn = "cn=Directory Manager",
            $ldap_bind_pw = undef,

            $ldap_root_dn = undef,

            $ldap_service_bind_dn = undef,
            $ldap_service_bind_pw = undef,

            $kolab_cache_sql_uri = "mysql://kolab:Welcome2KolabSystems@localhost/kolab",
            $kolab_webadmin_sql_uri = "mysql://kolab:Welcome2KolabSystems@localhost/kolab",

            $roundcubemail_des_key = 'rcmail-!24ByteDESkey*Str',
            $roundcubemail_dont_override = undef,
            $roundcubemail_skin = "larry",
            $roudncubemail_skin_logo = undef,

            $smtp_hostname = "$fqdn",
            $smtp_port = "587"
        ) {

    # Shortcuts to refer to from here on out
    $os = $::operatingsystem
    $osmajorver = $::lsbmajdistrelease

    $ldap_uri_read = $kolab::params::ldap_uri

    ##
    ## Do NOT touch anything below these lines.
    ##

    $imap_uri = "$imap_scheme://$imap_hostname:$imap_port"
    $ldap_uri = "$ldap_scheme://$ldap_hostname:$ldap_port"

    include "kolab::params::${kolab_version_name}"

    $kolab_version = getvar("kolab::params::${kolab_version_name}::kolab_version")
}
