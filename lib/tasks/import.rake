require "csv"
require "json"

namespace :kings do
  namespace :import do

    desc "recommended kingdoms from the official manuals"
    task recommended_kingdoms: :environment do
      user = User.find_by(username: "RecommendedKingdoms")

      recommended_kingdoms_csv do |name, cards_string, from_manual, extra_data|
        kingdom = Kingdom.new name: name
        kingdom.user = user
        kingdom.cards = parse_cards(cards_string)
        kingdom.description = build_description(from_manual, extra_data)
        kingdom.save
      end
    end

    def recommended_kingdoms_csv
      file = File.read "data/recommended_kingdoms.csv"

      CSV.parse(file, headers: true).each do |k| # kingdom
        yield k["name"], k["cards"], k["from_manual"], k["extra_data"]
      end
    end

    # "Thief,Chapel..." => [<Card id:...>, <Card id:...>]
    def parse_cards string
      string.split(",").map do |card_name|
        Card.find_by!(name: card_name)
      end
    end

    def build_description from_manual, extra_data
      description = "Official kingdom from the #{from_manual} manual."
      description << build_extra_data(extra_data)
    end

    # Ugly but OK...
    def build_extra_data extra_data
      return "" unless extra_data

      parsed = JSON.parse extra_data.tr("'", '"')
      string = ""
      string << " Bane: #{parsed['bane']}." if parsed["bane"]

      events = []
      events << parsed["event1"] << parsed["event2"]
      unless events.empty?
        events.compact!
        string << " Event"
        string << "s" if events.size > 1
        string << ": #{events.to_sentence}."
      end
      string
    end

  end
end
