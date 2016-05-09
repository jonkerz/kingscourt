# From http://makandracards.com/makandra/1709-single-step-and-
# slow-motion-for-cucumber-scenarios-using-javascript-selenium
# Use with `@javascript` and `DRIVER=selenium --format pretty` for the full experience.
Before '@slow_motion' do
  @slow_motion = true
end

After '@slow_motion' do
  @slow_motion = false
end

Transform /.*/ do |match|
  if @slow_motion
    sleep 1.5
  end
  match
end

AfterStep '@single_step' do
  single_step
end

if ENV['SINGLE_STEP']
  AfterStep do
    single_step
  end
end

def single_step
  print "Single Stepping. Hit enter to continue."
  STDIN.getc
end
