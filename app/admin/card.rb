ActiveAdmin.register Card do
  permit_params :name, :randomizable, :text,
    :expansion, :card_type
end
