class FilteredKingdomsSerializer
  def initialize kingdoms, view_context
    @kingdoms = kingdoms
    @view_context = view_context # TODO: Not nice!!
  end

  def as_json
    {
      kingdoms: serialized_kingdoms.as_json,
      meta: {
        count: kingdoms.total,
        expansion_facets: expansion_facets
      }
    }
  end

  private

    attr_reader :kingdoms, :view_context

    def serialized_kingdoms
      ActiveModel::Serializer::CollectionSerializer.new(
        kingdoms.results,
        each_serializer: KingdomSerializer,
        scope: view_context
      )
    end

    def expansion_facets
      facets = {}
      kingdoms.facet(:expansion_ids).rows.each do |row|
        facets[row.value] = row.count
      end
      facets
    end
end
