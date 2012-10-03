require 'spec_helper'

describe QualifiersHelper do
  context "instance methods" do
    describe "#twitterized_qualifier_class" do
      let(:twitter_classes) do
        {
          'negative' => 'text-error',
          'neutral'  => 'text-warning',
          'positive' => 'text-success'
        }
      end

      it "returns the twitter-bootstrap version for each flash type" do
        twitter_classes.each do |qualifier_type, twitter_class|
          helper.twitterized_qualifier_class(qualifier_type).should == twitter_class
        end
      end
    end
  end
end
