# Guide
# Search for "kotw" on Reddit, limit to r/dominon. View source and save
# that html page in data/reddit_kotw. Do the same with all results pages.
# Run `rake kings:import:reddit_kotw`.

require_relative "reddit_kotw"

namespace :kings do
  namespace :import do
    desc "Reddit 'Kingdom of the Week' kingdoms"
    task reddit_kotw: :environment do
      include Import::RedditKotW
      user = User.find_by username: "Reddit-KotW-Mirror"

      chunks(html_contents) do |name, cards, description, created_at|
        kingdom = Kingdom.new name: name
        kingdom.user = user
        kingdom.cards = cards
        kingdom.description = description
        kingdom.created_at = created_at
        kingdom.find_duplicates!
        kingdom.save! unless kingdom.errors.present?
        puts kingdom.valid? ? "Valid!!!".green : "not valid".red
      end
    end
  end
end
