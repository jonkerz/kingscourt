module Import
  module RecommendedKingdoms
    RELEASE_DATES = {
      "Dominion" => "October 2008",
      "Intrigue" => "July 2009",
      "Seaside" => "October 2009",
      "Alchemy" => "May 2010",
      "Prosperity" => "October 2010",
      "Cornucopia" => "June 2011",
      "Hinterlands" => "October 2011",
      "Dark Ages" => "August 2012",
      "Guilds" => "June 2013",
      "Adventures"  => "April 2015"
    }.transform_values { |date| Date.parse date }

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
