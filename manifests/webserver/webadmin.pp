class kolab::webserver::webadmin inherits kolab::webserver::common {
    $vhost_domain = getvar("kolab::params::kolab_primary_domain")

    webserver::virtualhost { "admin.${vhost_domain}":
        enable => true,
        certificate => true,
        template => "kolab/webserver/sites/admin.conf.erb"
    }

    realize(
            Package["kolab-webadmin"],
            Package["php-Smarty"],
            Webserver::Module::Enable["mod_authz_core"],
            Webserver::Module::Enable["mod_slotmem_shm"],
            Webserver::Module::Enable["mod_socache_shmcb"],
            Webserver::Module::Enable["mod_ssl"],
            Webserver::Module::Enable["mod_unixd"],
            Webserver::Module::Enable["php"]
        )
}
