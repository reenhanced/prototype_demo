Given /^today is "(.+)"( at ".+")?$/ do |date, time|
  if time
    time = time.split('"').last
    Timecop.travel(DateTime.parse("#{date} #{time}"))
  else
    Timecop.travel(Date.parse(date))
  end
end

Given /^the time is "(.+)"$/ do |time|
  Timecop.travel(Time.parse(time))
end

Then /^the current time zone should be "(.+)"$/ do |time_zone|
  Time.zone.name.should == time_zone
end

Then /^I should see the date( and time)? today$/ do |with_time|
  if with_time
    step %{I should see "#{DateTime.now}"}
  else
    step %{I should see "#{Date.today}"}
  end
end
