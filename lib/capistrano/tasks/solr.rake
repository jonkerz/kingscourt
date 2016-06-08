namespace :solr do
  %w(start stop).each do |command|
    desc "#{command} solr"
    task command do
      on roles(:app) do
        within release_path do
          # Not using `rake sunspot:solr` because Capistrano.
          execute :bundle, "exec sunspot-solr #{command} --port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
        end
      end
    end
  end

  task :reindex do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :bundle, "exec rake sunspot:solr:reindex"
        end
      end
    end
  end

  desc "ps aux | grep solr"
  task :grep do
    on roles(:app) do
      puts capture("ps aux | grep solr")
    end
  end
end
