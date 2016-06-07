# gem "whenever" config, see INSTALL.md

# Update crontab: `whenever --update -f ~/apps/kingscourt/current/config/backup/schedule.rb`
# Remove from crontab: `whenever -c -f ~/apps/kingscourt/current/config/backup/schedule.rb`
#
# Show crontab: `crontab -l`
# Edit crontab: `crontab -e`

every 1.day, at: "11:30 pm" do
  command "NO_PAPERTRAIL=true backup perform -t kingscourt_db_backup"
end

every 1.week, at: "11:40 pm" do
  command "backup perform -t kingscourt_db_backup"
end
