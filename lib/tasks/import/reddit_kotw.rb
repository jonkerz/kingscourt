module Import
  module RedditKotW
    def html_contents
      content = ""
      Dir.glob("data/reddit_kotw/*.html") do |file|
        content << File.read(file)
      end
      content
    end

    def chunks content
      extract_chunks(content).each do |chunk|
        title = extract_title chunk
        next if skip_title? title
        created_at = extract_time chunk

        name, title_without_name = extract_name_and_rest title
        # Add year to the name, "KotW 9/5 [2014]"
        name << " [#{created_at.year}]"

        cards_array, rest = extract_cards_and_rest title_without_name
        cards = parse_cards cards_array

        url = extract_url chunk
        description = build_description rest, url

        yield name, cards, description, created_at
      end
    end

    def extract_chunks content
      chunk_regex = /(search-result-header.*?<\/time>)/
      content.enum_for(:scan, chunk_regex).map { Regexp.last_match.to_s }
    end

    def extract_title chunk
      title = chunk[/may-blank" >(.*?)<\/a><\/header>/, 1]
      title.gsub! "KotW: 12/19:", "KotW 12/19:"
      title.gsub! "&quot;It's Terminal&quot;", ""
      title.gsub! "&quot;Renaissance Fair&quot;", ""
      title
    end

    def skip_title? title
      false_negatives = [
        "Just wanted to thank ya'll for KotW",
        "KotW Archive?"
      ]
      return true if false_negatives.any? { |item| title.include?(item) }

      false_positives = [
        "Kingdom of the Future 4/13",
        "Kingdom of the Future 4/5"
      ]
      return false if false_positives.any? { |item| title.include?(item)
      }

      # After taking care of the false positives/negatives, all titles
      # that contains "KotW" are assumed to be the real deal.
      return false if title["KotW"]

      puts "skipping title: #{title}".blue
      return true
    end

    def extract_name_and_rest title
      title.match(/^(.*?):(.*)/)[1..2]
    end

    # The "rest" here looks something like "Shelters. [Intrigue Prospetity]"
    def extract_cards_and_rest string
      split = string.split(/[.,;]/)

      # The first 10 should all be cards
      cards = split[0..9].map(&:strip)

      # Keep, because this may be a comment such as "No Colony/Platinum"
      rest = split[10..-1].join(", ")

      [cards, rest]
    end

    def parse_cards cards
      bad_card_names = [
        [/^Candlestick$/, "Candlestick Maker"],
        ["Young Witch (Sage as Bane)", "Young Witch"], # <-- Manually fix
        ["Young Witch (Bane: Menagerie)", "Young Witch"], # <-- Manually fix
        ["Watch Tower", "Watchtower"],
        ["Stewart", "Steward"]
      ]

      cards.map do |card_name|
        bad_card_names.each do |replacement|
          card_name.gsub! replacement.first, replacement.second
        end

        begin
          Card.find_by!(name: card_name)
        rescue ActiveRecord::RecordNotFound
          puts "'#{card_name}': card not found".red
          raise
        end
      end
    end

    def extract_time chunk
      time_regex = /datetime="(.*?)">/
      DateTime.parse chunk[time_regex, 1]
    end

    def build_description rest, url
      # Remove expansions, "[Dominion,  Seaside,  Hinterlands]"
      rest.gsub!(/\[.*?\]/, "") if rest

      # Still not empty, let's use this for the description.
      description = if rest.present?
                      rest.strip.gsub("  ", " ").gsub(/ ?,$/, "")
                    else
                      ""
                    end

      description << ". From #{url}."
    end

    def extract_url chunk
      url_regex = /(https:\/\/www.reddit.com\/r\/dominion\/comments.*?)\?ref=/
      chunk[url_regex, 1]
    end
  end
end
