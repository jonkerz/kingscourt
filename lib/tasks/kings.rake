require "csv"

namespace :kings do
  task remove_orphaned_kingdom_cards: :environment do
    KingdomCard.find_each do |kingdom_card|
      unless kingdom_card.kingdom
        puts "Deleted #{kingdom_card.id}, kingdom: #{kingdom_card.kingdom_id}"
        kingdom_card.delete
      end
    end
  end
end
