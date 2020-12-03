name 'oci_caas_pci_tomcat'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'The Universal Permissive License (UPL), Version 1.0'
description 'Installs/Configures oci_caas_pci_tomcat'
version '0.2.0'
chef_version '>= 16.0'

depends 'firewalld'
depends 'tomcat'
depends 'wazuh_agent'
depends 'clamav'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/oci_caas_pci_tomcat/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/oci_caas_pci_tomcat'
