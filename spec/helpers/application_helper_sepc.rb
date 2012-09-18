require 'spec_helper'

describe ApplicationHelper do
  context "instance methods" do
    describe "#twitterized_type" do
      let(:twitter_flashes) do
        {
          :alert => 'alert-block',
          :error => 'alert-error',
          :notice => 'alert-info',
          :success => 'alert-success'
        }
      end

      it "returns the twitter-bootstrap version for each flash type" do
        twitter_flashes.each do |flash_type, twitter_class|
          helper.twitterized_flash_class(flash_type).should == twitter_class
        end
      end
    end
  end
end
