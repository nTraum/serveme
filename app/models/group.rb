class Group < ActiveRecord::Base
  validates_presence_of :name

  has_many :users,    :through => :group_users
  has_many :group_users, -> { where("group_users.expires_at IS NULL OR group_users.expires_at > ?", Time.current)}, :dependent => :destroy

  has_many :servers,  :through => :group_servers
  has_many :group_servers, :dependent => :destroy

  attr_accessible :name

  def self.donator_group
    find_or_create_by(:name => "Donators")
  end

  def self.admin_group
    find_or_create_by(:name => "Admins")
  end

  def self.private_user(user)
    where(:name => user.uid).first_or_create!
  end

end
