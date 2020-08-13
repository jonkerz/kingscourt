module Import
  class FindKingdomWithIdenticalCards
    def initialize kingdom
      @kingdom = kingdom
    end

    def call
      find_duplicates!
    end

    private

      attr_reader :kingdom

      def find_duplicates!
        Kingdom.find_each do |kingdom|
          if kingdom.card_ids.sort == card_ids.sort
            errors.add :base, "'#{name}' looks like a duplicate '#{kingdom.name}'" # TODO: Hmm.
          end
        end
      end
  end
end
