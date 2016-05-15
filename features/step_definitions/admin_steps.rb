When /^I go to the admin panel$/ do
  visit "/the_court/admin"
end

Given /^there is an admin user named KingsAdmin$/ do
  create :user,
    username: "KingsAdmin",
    email: "admin@example.com",
    admin: true
end

When /^I sign in$/ do
  find('input[name="commit"]').click
end
