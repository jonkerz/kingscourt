### Installation (Ubuntu 14.04)

##### Checkout repo
```bash
git clone https://github.com/jonkerz/kingscourt
cp .env.example .env # edit database credentials here
```

##### Dependencies (server and local)
```bash
sudo apt-get update
sudo apt-get git # git

# MySQL
sudo apt-get install mysql-server libmysqlclient-dev

# RVM/Ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements

# Bundler
rvm install ruby-2.2.2
rvm use 2.2.2 --default
gem install bundler -V --no-ri --no-rdoc

# Node/npm/Bower
sudo apt-get install nodejs nodejs-legacy npm
sudo npm install bower -g

# Prod only
# nginx
sudo apt-get install curl git-core nginx -y
```

##### Install locally
```bash
bundle install # install gems
bundle exec rake bower:install # install Bower components

# Database. Make sure you have edited .env
bundle exec rake db:create && rake db:schema:load
bundle exec rake db:test:prepare

# Run tests
bundle exec cucumber # feature tests
bundle exec rspec # unit tests
bundle exec teaspoon # JavaScript unit-ish tests

# Run site
bundle exec rake sunspot:solr:start # start Solr
bundle exec rake sunspot:solr:reindex # reindex Solr
bundle exec rails s # start the app, visit http://localhost:3000/
```

##### Install on server
###### Initial deploy
```bash
# Login to server
local$ ssh root@kingscourt.io

# Add deploy user
root$ rootadduser deploy
root$ gpasswd -a deploy sudo
root$ exit

# Copy ssh key
local$ ssh-keygen
local$ ssh-copy-id deploy@kingscourt.io
# or local$ cat ~/.ssh/id_rsa.pub | ssh deploy@kingscourt.io 'cat >> ~/.ssh/authorized_keys' # Possible fix: `ssh-add`

# GitHub deploy key
deploy$ ssh -T git@github.com
deploy$ ssh-keygen -t rsa
# Add the key to the repo (see https://developer.github.com/guides/managing-deploy-keys/)

# Initial deploy
local$ cap production deploy
local$ cap production invoke:rake TASK=sunspot:solr:start
local$ cap production invoke:rake TASK=sunspot:solr:reindex

# Symlink nginx
deploy$ sudo rm /etc/nginx/sites-enabled/default
deploy$ sudo ln -nfs "/home/deploy/apps/kingscourt/current/config/nginx.conf" "/etc/nginx/sites-enabled/kingscourt"
deploy$ sudo service nginx restart

# Copy environment variables
# Copy DEV_DB_* and SECRET_KEY_BASE from .env to /etc/environment (deploy$)

# Disable public Solr admin interface
deploy$ sudo iptables -A INPUT -p tcp -s localhost --dport 8983 -j ACCEPT
deploy$ sudo iptables -A INPUT -p tcp --dport 8983 -j DROP
deploy$ sudo apt-get install iptables-persistent
deploy$ sudo invoke-rc.d iptables-persistent save # Make persist iptables

# Redirect www to no-www
# Add a new 'www @' DNS A record (use Google)

# Enable automatic database backups to Dropbox (optional)
deploy$ gem install backup -v '~> 4.0' # not in Gemfile because reasons, also, takes forever to install
deploy$ gem install whenever
# Setup Dropbox app at https://www.dropbox.com/developers/apps
deploy$ mkdir -p ~/Backup/models # yes, capital B
deploy$ ln -s ~/apps/kingscourt/current/config/backup/config.rb ~/Backup/config.rb
deploy$ ln -s ~/apps/kingscourt/current/config/backup/models/kingscourt_db_backup.rb ~/Backup/models/kingscourt_db_backup.rb
deploy$ whenever --update -f ~/apps/kingscourt/current/config/backup/schedule.rb
```

##### Deploying new changes
```bash
local$ git push origin master
local$ cap production deploy # append COPY_BOWER=true to reuse bower_components from the previous deploy
```

#### Stuff
A lot of this is based on [Initial Server Setup with Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04) and [Deploying a Rails App on Ubuntu 14.04 with Capistrano, Nginx, and Puma](https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma).

###### Copy card assets
```bash
# Card assets are copyrighted by someone, thus not included in the repo.
local$ scp -r public/cards deploy@kingscourt.io:/home/deploy/apps/kingscourt/shared/public
```

###### Database: Export/import
```bash
# Export database
local$ mysqldump -u root -p kingscourt_dev > kingscourt.sql
local$ scp kingscourt.sql deploy@kingscourt.io:~/ # copy dumped filed to server

# Import database
deploy$ echo "drop database kingscourt;" | mysql -u root -p
deploy$ echo "create database kingscourt;" | mysql -u root -p
deploy$ mysql -u root -p kingscourt < kingscourt.sql
```

###### Rake tasks
See `rake -T kings` for 100% custom Rake tasks, and remember to check out `cap -T` for all Capistrano tasks. Some stuff:

```bash
cap rails:console # remote console, very neat
cap db:pull # sync db, destructive
cap db:push # ditto
cap deploy:pending # commits since last deploy
cap deploy:pending:diff
cap invoke:rake TASK=notes # run Rake tasks on the server
```
