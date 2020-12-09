# Wazuh (ossec) settings
override['ossec']['conf']['client']['server']['address'] = node['ossec']['registration_address']

default['ossec']['conf']['syscheck']['ignore'] = [
  '/etc/mtab',
  '/etc/hosts.deny',
  '/etc/mail/statistics',
  '/etc/random-seed',
  '/etc/random.seed',
  '/etc/adjtime',
  '/etc/httpd/logs',
  '/etc/utmpx',
  '/etc/wtmpx',
  '/etc/cups/certs',
  '/etc/dumpdates',
  '/etc/svc/volatile',
  '/sys/kernel/security',
  '/sys/kernel/debug',
  '/dev/core',
  { '@type' => 'sregex', 'content!' => '^/proc' },
  { '@type' => 'sregex', 'content!' => '.log$|.swp$' },
]

default['ossec']['conf']['syscheck']['directories'] = [
  { '@check_all' => true, 'content!' => '/etc,/usr/bin,/usr/sbin' },
  { '@check_all' => true, 'content!' => '/bin,/sbin,/boot' },
  { '@check_all' => true, 'content!' => '/var/log/secure-*,/var/log/messages-*' },
]

# ClamAV settings
default['clamav']['clamd']['enabled'] = true
default['clamav']['freshclam']['enabled'] = true
default['clamav']['dev_package'] = false