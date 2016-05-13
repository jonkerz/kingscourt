When /^I open the "([^"]*)" panel$/ do |title|
  find("h4.panel-title > a", text: title).click
end

When /^I toggle the expansions "([^"]*)"( and reload)?$/ do |expansions, reload|
  expansions.split(", ").each do |expansion|
    find(".expansion-selector label", text: expansion).click
  end
  find("button", text: "Filter").click if reload
end
