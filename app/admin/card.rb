ActiveAdmin.register Card do
  filter :card_attributes, as: :check_boxes
  preserve_default_filters!

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
    actions
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
      row 'Attributes' do |object|
        object.card_attributes.map(&:name).join("<br />").html_safe
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

  controller do
    def permitted_params
      params.permit!
    end
  end
end
