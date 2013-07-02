require 'spec_helper'

describe UserDecorator do

  let(:user) { build(:server, :name => "Name") }
  subject { UserDecorator.new(user) }

  describe "#nickname" do

    context "donator" do

      it "decorates the nickname with a donator icon" do
        user.stub(:donator? => true)
        user.stub(:nickname => "Foo")
        subject.nickname.should == 'Foo <icon class="icon-star" title="Donator"></icon>'
      end
    end

    context "non-donator" do

      it 'does not decorate the nickname with the donator icon' do
        user.stub(:donator? => false)
        user.stub(:nickname => "Bar")
        subject.nickname.should == 'Bar'
      end

    end

  end

end