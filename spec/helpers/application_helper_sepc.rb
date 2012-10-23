require 'spec_helper'

describe ApplicationHelper do
  context "instance methods" do
    describe "#bootstrap_class" do
      let(:twitter_classes) do
        {
          :alert => {
            :alert   => 'alert-block',
            :error   => 'alert-error',
            :notice  => 'alert-info',
            :success => 'alert-success'
          },
          :text => {
            :negative => 'text-error',
            :neutral  => 'text-warning',
            :positive => 'text-success'
          },
          :label => {
            :negative => 'label-important',
            :neutral  => 'label-warning',
            :positive => 'label-success',
            :create   => 'label-info',
            :update   => 'label-success',
            :destroy  => 'label-important'
          }
        }
      end

      it "returns the twitter-bootstrap version for each flash type" do
        twitter_classes.each do |label_type, twitter_classes|
          twitter_classes.each do |type, twitter_class|
            helper.bootstrap_class(type, type: label_type).should == twitter_class
          end
        end
      end
    end
  end
end
