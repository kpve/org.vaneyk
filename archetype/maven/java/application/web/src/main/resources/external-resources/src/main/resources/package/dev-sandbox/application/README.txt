
In non-development environments your war file would be installed here.  In development environments maven's jetty plugin
is configured to use your project's web module source files for quicker development cycles.  To actuall install the war
file here just use -Dinstall-application when you build (mvn package) the web module.  You can then point any standard
web application container (tomcat, glassfish, jetty) at the war file location and it should run using the resources
in the rest of the standard install directory (config files, logs etc.)

