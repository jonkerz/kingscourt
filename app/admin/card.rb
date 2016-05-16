ActiveAdmin.register Card do
  filter :card_attributes, as: :check_boxes
  preserve_default_filters!

  config.per_page = 60

  Expansion.all.each do |expansion|
    scope expansion.name do |scope|
      scope.where(expansion_id: expansion.id)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :randomizable
    column :cost
    column :cost_in_coins
    column :text
    column :expansion_id
    column :card_type_id
    column "Image" do |card|
      span do
        image_tag "/cards/#{card.image}", width: 100
      end
    end
    column 'Attributes' do |card|
      card.card_attributes.map(&:name).join(", ").html_safe
    end
    actions
  end

  index as: :grid, columns: 5 do |card|
    link_to image_tag("/cards_large/#{card.image}"), admin_card_path(card)
  end

  show do
    attributes_table do
      row :id
      row :name
      row :randomizable
      row :cost
      row :cost_in_coins
      row :text
      row :expansion_id
      row :card_type_id
      row :updated_at
      row :created_at
      row 'Attributes' do |card|
        card.card_attributes.map(&:name).join(", ").html_safe
      end
    end
  end

  form do |f|
    f.inputs "Attributes" do
      f.input :name
      f.input :randomizable
      f.input :cost
      f.input :cost_in_coins
      f.input :text
      f.input :expansion
      f.input :card_type
      f.input :card_attributes, as: :check_boxes
    end
    f.actions
  end

  sidebar :image, only: [:show, :edit] do
    @card = Card.find(params[:id])
    image_tag "/cards_large/#{@card.image}", width: 200
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
