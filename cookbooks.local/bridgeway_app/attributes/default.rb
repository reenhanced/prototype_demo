default['rvm']['rvmrc_env'] = {
  'rvm_project_rvmrc' => 1,
  'rvm_trust_rvmrcs_flag' => 1
}

default['postgresql']['config']['listen_addresses'] = '*'
default['postgresql']['pg_hba'] = [
  { type: 'local', db: 'all', user: 'all', addr: nil,            method: 'trust'},
  { type: 'host',  db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'trust'},
  { type: 'host',  db: 'all', user: 'all', addr: '10.0.0.0/8',   method: 'trust'}
]

