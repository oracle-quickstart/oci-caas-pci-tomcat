# Wazuh (ossec) settings
override['ossec']['conf']['client']['server']['address'] = node['ossec']['registration_address']

# ClamAV settings
default["clamav"]["clamd"]["enabled"] = true
default["clamav"]["freshclam"]["enabled"] = true
default["clamav"]["dev_package"] = false