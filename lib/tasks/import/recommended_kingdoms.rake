require "csv"
require "json"
require_relative "recommended_kingdoms"

namespace :kings do
  namespace :import do
    desc "recommended kingdoms from the official manuals"
    task recommended_kingdoms: :environment do
      include Import::RecommendedKingdoms
      user = User.find_by username: "RecommendedKingdoms"

      recommended_kingdoms_csv do |name, cards_string, from_manual, extra_data|
        kingdom = Kingdom.new name: name
        kingdom.user = user
        kingdom.cards = parse_cards(cards_string)
        kingdom.description = build_description(from_manual, extra_data)
        kingdom.created_at = RELEASE_DATES[from_manual]
        kingdom.save
      end
    end
  end
end
