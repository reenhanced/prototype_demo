require 'spec_helper'

describe QualifiersHelper do
  context "instance methods" do
    describe "#bootstrap_class_for_qualifier_type" do
      let(:twitter_classes) do
        {
          :text => {
            'negative' => 'text-error',
            'neutral'  => 'text-warning',
            'positive' => 'text-success'
          },
          :label => {
            'negative' => 'label-important',
            'neutral'  => 'label-warning',
            'positive' => 'label-success'
          }
        }
      end

      it "returns the twitter-bootstrap version for each qualifier type" do
        twitter_classes[:text].each do |qualifier_type, twitter_class|
          helper.bootstrap_class_for_qualifier_type(qualifier_type).should == twitter_class
        end
      end

      it "returns the twitter-bootstrap label version for each qualifier type when specified" do
        twitter_classes[:label].each do |qualifier_type, twitter_class|
          helper.bootstrap_class_for_qualifier_type(qualifier_type, element_type: :label).should == twitter_class
        end
      end
    end
  end
end
