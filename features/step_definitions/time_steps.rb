Given /^today is "(.+)"$/ do |day|
  Timecop.travel(Date.parse(day))
end

Given /^the time is "(.+)"$/ do |time|
  Timecop.travel(Time.parse(time))
end

Then /^the current time zone should be "(.+)"$/ do |time_zone|
  Time.zone.name.should == time_zone
end
