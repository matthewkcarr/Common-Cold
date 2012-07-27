set :keep_releases, 2
set :runner, nil
set :user, 'elleande'
set :scm_username, 'elleande'
set :use_sudo, false
set :application, 'commoncoldinc'
#set :repository,  "svn+ssh://#{scm_username}@maple.site5.com/home/elleande/svn/projects/#{application}"
set :repository,  "file:///home/#{scm_username}/svn/projects/#{application}"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/elleande/projects/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, 'maple.site5.com'
role :web, 'maple.site5.com'
role :db,  'maple.site5.com', :primary => true

desc "Restart the web server. Overrides the default task for Site5 use."
deploy.task :restart, :roles => :app do
  run "cd /home/#{user}/public_html; rm -rf #{application}; ln -s #{current_path}/public ./#{application}"
  run "skill -9 -u #{user} -c dispatch.fcgi"
end
