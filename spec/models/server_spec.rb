require 'spec_helper'

describe Server do

  describe '.with_group' do

    it 'should find servers in a group' do
      group       = create :group, :name => "Great group"
      other_group = create :group, :name => "Other group"
      server_in_group     = create :server, :groups => [group], :name => "server in group"
      server_not_in_group = create :server, :name => "server in no groups"
      server_other_group  = create :server, :groups => [other_group], :name => "server other group"

      Server.with_group.should =~ [server_in_group, server_other_group]
    end

  end

  describe '.in_groups' do

    it 'should find servers belonging to a certain group' do
      group       = create :group, :name => "Great group"
      other_group = create :group, :name => "Other group"
      server_in_group     = create :server, :groups => [group], :name => "server in group"
      server_not_in_group = create :server, :name => "server in no groups"
      server_other_group  = create :server, :name => "server other group", :groups => [other_group]

      Server.in_groups([group]).should == [server_in_group]
    end

    it 'should only return servers once even with multiple matching groups' do
      group       = create :group, :name => "Great group"
      group2      = create :group, :name => "Great group 2"
      other_group = create :group, :name => "Other group"
      server_in_group     = create :server, :groups => [group, group2], :name => "server in group"
      server_not_in_group = create :server, :name => "server in no groups"
      server_other_group  = create :server, :name => "server other group", :groups => [other_group]

      Server.in_groups([group, group2]).should == [server_in_group]
    end

  end

  describe '.reservable_by_user' do

    it "returns servers in the users group and servers without groups regardless of reservations" do
      users_group                 = create :group,  :name => "User's group"
      other_group                 = create :group,  :name => "Not User's group"
      user                        = create :user,   :groups => [users_group]
      free_server_in_users_group  = create :server, :groups => [users_group], :name => "free server in user's group"
      busy_server_in_users_group  = create :server, :groups => [users_group], :name => "busy server in user's group"
      free_server_other_group     = create :server, :groups => [other_group], :name => "free server not in user's group"
      free_server_no_group        = create :server, :groups => []
      busy_server_no_group        = create :server, :groups => []
      create :reservation, :server => busy_server_in_users_group, :user => user
      create :reservation, :server => busy_server_no_group

      Server.reservable_by_user(user).should =~ [free_server_in_users_group, busy_server_in_users_group, free_server_no_group, busy_server_no_group]
    end

  end

  describe '#restart' do

    it "sends the software termination signal to the process" do
      subject.should_receive(:process_id).at_least(:once).and_return { 1337 }
      Process.should_receive(:kill).with(15, 1337)
      subject.restart
    end

  end

end
