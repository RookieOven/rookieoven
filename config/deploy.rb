require 'mina/git'

set :domain, '178.62.122.53'
set :deploy_to, '/var/www/addjam.com'
set :user, 'deploy'
set :shared_paths, []
set :forward_agent, true

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    queue "docker pull addjam/www"

    to :launch do
      queue "docker stop www"
      queue "docker rm www"
      queue "docker run --name www -p 80:80 -td addjam/www:latest"
    end
  end
end
