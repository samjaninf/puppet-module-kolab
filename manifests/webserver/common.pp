class kolab::webserver::common inherits kolab::common {
    class { '::webserver':
        httpd_version => getvar("kolab::pkg::httpd_version"),
        php_version => getvar("kolab::pkg::php_version")
    }

    @file { "/etc/php.d/apc.ini":
        owner => "root",
        group => "apache",
        mode => "640",
        source => [
                "puppet://$server/private/$environment/php/php.d.$hostname/apc.ini",
                "puppet://$server/private/$environment/php/php.d/apc.ini.$hostname",
                "puppet://$server/private/$environment/php/php.d/apc.ini",
                "puppet://$server/files/php/php.d.$hostname/apc.ini",
                "puppet://$server/files/php/php.d/apc.ini.$hostname",
                "puppet://$server/files/php/php.d/apc.ini",
                "puppet://$server/kolab/php/php.d/apc.ini",
            ],
        notify => Service["httpd"]
    }

    @file { "/etc/php.d/memcache.ini":
        owner => "root",
        group => "apache",
        mode => "640",
        content => template("kolab/php/php.d/memcache.ini.erb"),
        notify => Service["httpd"]
    }

    @file { "/etc/roundcubemail/":
        owner => "root",
        group => "apache",
        recurse => true,
        purge => true,
        force => true,
        source => [
                "puppet://$server/private/$environment/files/roundcubemail.$hostname/",
                "puppet://$server/private/$environment/files/roundcubemail/"
            ]
    }

    @file { "/etc/roundcubemail/calendar.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/calendar.inc.php.erb")
    }

    @file { "/etc/roundcubemail/config.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/config.inc.php.erb")
    }

    @file { "/etc/roundcubemail/kolab_auth.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/kolab_auth.inc.php.erb")
    }

    @file { "/etc/roundcubemail/kolab_auth.syncroton.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/kolab_auth.syncroton.inc.php.erb")
    }

    @file { "/etc/roundcubemail/kolab_delegation.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/kolab_delegation.inc.php.erb")
    }

    @file { "/etc/roundcubemail/kolab_folders.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/kolab_folders.inc.php.erb")
    }

    @file { "/etc/roundcubemail/kolab.inc.php":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/libkolab.inc.php"
    }

    @file { "/etc/roundcubemail/libkolab.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/libkolab.inc.php.erb")
    }

    @file { "/etc/roundcubemail/managesieve.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/managesieve.inc.php.erb")
    }

    @file { "/etc/roundcubemail/password.inc.php":
        mode => "640",
        owner => "root",
        group => "apache",
        content => template("kolab/roundcubemail/password.inc.php.erb")
    }

    @file { "/usr/share/kolab-syncroton/lib/plugins/kolab_auth/config.inc.php":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/kolab_auth.syncroton.inc.php",
        require => Package["kolab-webclient"]
    }

    @file { "/usr/share/roundcubemail/skins/kolab/images/kolab_corporate_logo.png":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/kolab_corporate_logo.png"
    }

    @file { "/usr/share/roundcubemail/skins/kolab/images/lhm_logo_206x36.png":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/lhm_logo_206x36.png"
    }

    @file { "/usr/share/roundcubemail/skins/kolab/images/logo-dark.png":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/logo-dark.png"
    }

    @file { "/usr/share/roundcubemail/skins/kolab/images/watermark.jpg":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/watermark.jpg"
    }

    @file { "/usr/share/roundcubemail/skins/kolab/images/favicon.ico":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/favicon.ico"
    }

    @file { "/usr/share/roundcubemail/skins/kolab/templates/about.html":
        ensure => link,
        links => manage,
        target => "/etc/roundcubemail/about-lhm_klab_cc.html"
    }

    @package { "chwala":
        ensure => getvar("kolab::pkg::chwala_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    @package { "kolab-webadmin":
        ensure => getvar("kolab::pkg::kolab_webadmin_version"),
        require => [
                Package["php-Smarty"]
            ]
    }

    @package { "php-Smarty":
        ensure => getvar("kolab::pkg::php_smarty_version")
    }

    @package { "php-pecl-apc":
        ensure => getvar("kolab::pkg::php_pecl_apc_version")
    }

    @package { "php-pecl-memcache":
        ensure => getvar("kolab::pkg::php_pecl_memcache_version")
    }

    @package { "roundcubemail":
        ensure => getvar("kolab::pkg::roundcubemail_version")
    }

    @package { "roundcubemail-plugin-archive":
        ensure => getvar("kolab::pkg::roundcubemail_plugin_archive_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    @package { "roundcubemail-plugin-contextmenu":
        ensure => getvar("kolab::pkg::roundcubemail_plugin_contextmenu_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    @package { "roundcubemail-plugin-markasjunk":
        ensure => getvar("kolab::pkg::roundcubemail_plugin_markasjunk_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    @package { "roundcubemail-plugin-redundant_attachments":
        ensure => getvar("kolab::pkg::roundcubemail_plugin_redundant_attachments_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    @package { "roundcubemail-plugins-kolab":
        ensure => getvar("kolab::pkg::roundcubemail_plugins_kolab_version"),
        require => [
                Package["roundcubemail"]
            ]
    }

    # A reasonable minimal set of modules
    if (!defined(Webserver::Module::Enable["mod_alias"])) {
        @webserver::module::enable { "mod_alias": }
    }

    if (!defined(Webserver::Module::Enable["mod_authz_core"])) {
        @webserver::module::enable { "mod_authz_core": }
    }

    if (!defined(Webserver::Module::Enable["mod_authz_host"])) {
        @webserver::module::enable { "mod_authz_host": }
    }

    if (!defined(Webserver::Module::Enable["mod_deflate"])) {
        @webserver::module::enable { "mod_deflate": }
    }

    if (!defined(Webserver::Module::Enable["mod_dir"])) {
        @webserver::module::enable { "mod_dir": }
    }

    if (!defined(Webserver::Module::Enable["mod_env"])) {
        @webserver::module::enable { "mod_env": }
    }

    if (!defined(Webserver::Module::Enable["mod_expires"])) {
        @webserver::module::enable { "mod_expires": }
    }

    if (!defined(Webserver::Module::Enable["mod_headers"])) {
        @webserver::module::enable { "mod_headers": }
    }

    if (!defined(Webserver::Module::Enable["mod_log_config"])) {
        @webserver::module::enable { "mod_log_config": }
    }

    if (!defined(Webserver::Module::Enable["mod_mime"])) {
        @webserver::module::enable { "mod_mime": }
    }

    if (!defined(Webserver::Module::Enable["mod_reqtimeout"])) {
        @webserver::module::enable { "mod_reqtimeout": }
    }

    if (!defined(Webserver::Module::Enable["mod_rewrite"])) {
        @webserver::module::enable { "mod_rewrite": }
    }

    if (!defined(Webserver::Module::Enable["mod_security"])) {
        @webserver::module::enable { "mod_security": }
    }

    if (!defined(Webserver::Module::Enable["mod_setenvif"])) {
        @webserver::module::enable { "mod_setenvif": }
    }

    if (!defined(Webserver::Module::Enable["mod_slotmem_shm"])) {
        @webserver::module::enable { "mod_slotmem_shm": }
    }

    if (!defined(Webserver::Module::Enable["mod_socache_shmcb"])) {
        @webserver::module::enable { "mod_socache_shmcb": }
    }

    if (!defined(Webserver::Module::Enable["mod_ssl"])) {
        @webserver::module::enable { "mod_ssl": }
    }

    if (!defined(Webserver::Module::Enable["mod_status"])) {
        @webserver::module::enable { "mod_status": }
    }

    if (!defined(Webserver::Module::Enable["mod_unixd"])) {
        @webserver::module::enable { "mod_unixd": }
    }

    if (!defined(Webserver::Module::Enable["php"])) {
        @webserver::module::enable { "php": }
    }
}
