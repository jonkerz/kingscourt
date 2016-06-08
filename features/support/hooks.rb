# Some drivers (eg selenium) remembers the window
# size between tests, so always restore.
Before "@responsive" do
  resize_window_to_device :large
end

After "@responsive" do
  resize_window_to_device :large
end

# Fix windows size on Travis CI (xvfb + selenium = too small)
Before "@travis" do
  resize_window_to_device :large
end

After "@travis" do
  resize_window_to_device :large
end

# Debug hooks.
Before "@slow_motion" do
  @slow_motion = true
end

After "@slow_motion" do
  @slow_motion = false
end

Transform /.*/ do |match|
  sleep 1.5 if @slow_motion
  match
end

AfterStep "@single_step" do
  single_step
end

# "Single Step Selenium"
# "Single Step Pry"
if ENV["SS"] || ENV["SSS"] || ENV["SSP"]
  AfterStep do
    if ENV["SSP"]
      binding.pry
    else
      single_step
    end
  end
end

def single_step
  print "Single Stepping. Hit enter to continue."
  STDIN.getc
end
