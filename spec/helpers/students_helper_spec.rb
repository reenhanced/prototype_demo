require 'spec_helper'

RSpec.describe StudentsHelper do
  context "instance methods" do
    describe "#options_for_graduation_year" do
      it "returns an array of years starting from this year and ending on the offset" do
        start_year = Date.today.year
        end_year   = start_year + Student::GRADUATION_YEAR_OFFSET
        helper.options_for_graduation_year.first.should == [start_year, start_year]
        helper.options_for_graduation_year.last.should == [end_year, end_year]
        helper.options_for_graduation_year.should have(Student::GRADUATION_YEAR_OFFSET + 1).arrays
      end
    end
  end
end
