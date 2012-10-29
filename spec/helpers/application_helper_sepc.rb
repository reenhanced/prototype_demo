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

    describe "#address_tag_for" do
      let(:family_card) { create(:family_card, :with_address) }
      let(:family_member) { family_card.default_parent }

      it "returns an address tag with the full address" do
        helper.address_tag_for(family_member).should include(family_member.address1)
        helper.address_tag_for(family_member).should include(family_member.address2)
        helper.address_tag_for(family_member).should include(family_member.city)
        helper.address_tag_for(family_member).should include(family_member.state)
        helper.address_tag_for(family_member).should include(family_member.zip_code)
        helper.address_tag_for(family_member).should include(", ")
      end

      it "returns a correctly formatted address tag even for partial addresses" do
        family_member.city = ""
        helper.address_tag_for(family_member).should include(family_member.address1)
        helper.address_tag_for(family_member).should include(family_member.city)
        helper.address_tag_for(family_member).should include(family_member.state)
        helper.address_tag_for(family_member).should include(family_member.zip_code)
        helper.address_tag_for(family_member).should_not include(", ")
        helper.address_tag_for(family_member).should_not include("<br /><br />")
      end
    end
  end
end
