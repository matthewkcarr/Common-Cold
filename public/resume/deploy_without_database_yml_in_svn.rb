set :production_database, "production_database_name"
set :production_username, "production_database_login_name"
set :production_password, "production_database_password"

#port: <%= mysql_port %> #may want to add mysql port to database_configuration
desc "Create database.yml in shared/config"
task :after_setup do
  login = render :template => <<-EOF

  adapter: mysql
  host: localhost
  username: <%= "#{production_username}" %>
  password: <%= "#{production_password}" %>
  EOF

  database_configuration = render :template => <<-EOF

development:
  database: <%= "#{application}_development" %>
  <%= "#{login}" %>

test:
  database: <%= "#{application}_test" %>
  <%= "#{login}" %>

production:
  database: <%= "#{production_database}" %>
  <%= "#{login}" %>
  EOF

  run "mkdir -p #{deploy_to}/#{shared_dir}/config"
  put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml"
  run "chmod 644 #{deploy_to}/#{shared_dir}/config/database.yml"
end

desc "Link in the production database.yml"
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
end

