module DeviseHelpers
  def auth_headers_for user
    user.create_new_auth_token
  end
end
