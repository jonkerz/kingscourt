module ByNameOrId
  extend ActiveSupport::Concern

  included do
    class << self; alias_method :[], :by_name_or_id end
  end

  module ClassMethods
    def by_name_or_id name_or_id
      if name_or_id.is_a? Integer
        find(name_or_id)
      else
        find_by!(name: name_or_id)
      end
    end
  end
end
