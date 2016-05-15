ActiveAdmin.setup do |config|
  config.site_title = "King's Court"
  config.site_title_link = "/"
  config.default_namespace = false
  config.authentication_method = :authenticate_active_admin_user!
  # config.authorization_adapter = ActiveAdmin::CanCanAdapter
  # config.cancan_ability_class = "Ability"
  # config.on_unauthorized_access = :access_denied
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  # config.root_to = 'dashboard#index'

  config.comments = false
  # config.comments_registration_name = 'AdminComment'
  # config.comments_order = 'created_at ASC'
  # config.comments_menu = false
  # config.comments_menu = { parent: 'Admin', priority: 1 }

  config.batch_actions = true
  config.localize_format = :long
  # config.favicon = 'favicon.ico'
  # config.breadcrumb = false
  # config.default_per_page = 30
  # config.max_per_page = 10_000
  # config.filters = true
  # config.include_default_association_filters = true
end
