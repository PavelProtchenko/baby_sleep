require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :application_name, 'baby_sleep'
set :domains, %w[ec2-54-187-207-88.us-west-2.compute.amazonaws.com]
set :user, 'ubuntu'
set :deploy_to, '/var/www/baby_sleep'
set :repository, 'git@github.com:SuperPavel/baby_sleep.git'
set :branch, 'master'
set :port, '2222'

set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/master.key',
  'config/sitemap.rb', 'config/schedule.rb', 'log'
)

task :remote_environment do
  invoke :'rvm:use', 'ruby-2.5.1'
end

task :env do
  command %[#{echo_cmd %[source ~/.bash_profile]}]
end

task :setup do
  command %[mkdir -p "#{fetch(:shared_path)}/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/config"]

  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/master.key"]
  command %[touch "#{fetch(:shared_path)}/config/sitemap.rb"]
  command %[touch "#{fetch(:shared_path)}/config/schedule.rb"]
end

set :shared_dirs, fetch(:shared_dirs, []).push('public/uploads')

desc 'Deploy to server in domains array'
task :deploy do
  fetch(:domains).each do |domain|
    set :domain, domain
    invoke :'env'
    deploy do
      invoke :'git:clone'
      invoke :'deploy:link_shared_paths'
      invoke :'bundle:install'
      invoke :'rails:db_migrate'
      invoke :'rails:assets_precompile'
      invoke :'deploy:cleanup'

      # on :launch do
      #   command %[kill -s SIGUSR1 $(ps -C ruby -F | grep 'puma' | awk {'print $2'})]
      #   command %[kill -s SIGUSR1 $(ps -C ruby -F | grep 'sidekiq' | awk {'print $2'})]
      # end
    end
  end
end
