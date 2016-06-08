Model.new(:kingscourt_db_backup, "Backups the database only") do
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV["PROD_DB_NAME"]
    db.username           = ENV["PROD_DB_USER"]
    db.password           = ENV["PROD_DB_PASSWORD"]
    db.host               = "localhost"
    db.port               = 3306
    db.skip_tables        = ["versions"] if ENV["NO_PAPERTRAIL"]
    # db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
  end

  store_with Dropbox do |db|
    db.api_key     = ENV["DROPBOX_API_KEY"]
    db.api_secret  = ENV["DROPBOX_API_SECRET"]
    # Sets the path where the cached authorized session will be stored.
    # Relative paths will be relative to ~/Backup, unless the --root-path
    # is set on the command line or within your configuration file.
    db.cache_path  = ".cache"
    db.access_type = :app_folder
    db.keep        = 25
    # Remove all backups older than 1 month.
    # db.keep      = Time.now - 2592000
  end

  compress_with Gzip
end
