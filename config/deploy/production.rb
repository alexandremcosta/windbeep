server ENV['PRODUCTION_SERVER_IP'], user: 'deploy', roles: %w{app db web}
set :stage, :production

