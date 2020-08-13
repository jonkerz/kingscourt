When /^I resize the browser window to (extra_small|small|medium|large)$/ do |device|
  resize_window_to_device device
end

Then /^I should see the menu hamburger$/ do
  expect(page).to have_css(".navbar-toggle")
end

Then /^I should not see the menu hamburger$/ do
  expect(page).to have_no_css(".navbar-toggle")
end

# Widths from Bootstrap.
def resize_window_to_device device
  size = case device.to_sym
         when :extra_small then [480, 480]
         when :small       then [768, 640]
         when :medium      then [992, 768]
         when :large       then [1200, 768]
         end

  # HACK: to get the correct size. Perhaps capybara-webkit
  # includes scrollbars etc in the width?
  if Capybara.current_driver == :webkit
    return resize_window size.first + 100, size.second
  end
  resize_window(*size)
end

# From http://railsware.com/blog/2015/02/11/responsive-layout-tests-with-capybara-and-rspec/
def resize_window width, height
  case Capybara.current_driver
  when :selenium
    Capybara.current_session.driver.browser.manage.window.
      resize_to(width, height)
  when :webkit
    handle = Capybara.current_session.driver.current_window_handle
    Capybara.current_session.driver.
      resize_window_to(handle, width, height)
  else
    raise NotImplementedError,
      "resize_window is not supported for #{Capybara.current_driver} driver"
  end
end
