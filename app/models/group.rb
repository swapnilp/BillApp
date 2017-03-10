class Group < ActiveRecord::Base
  has_many :group_members
  has_many :group_transactions
  has_many :group_audits

  validates :name, uniqueness: { scope: :user_id,
    message: "should happen once per user" }

  after_create :add_admin

  def add_members(members)
    members.each do |mem|
      self.group_members.find_or_create_by({user_id: mem}).save
    end
    
  end

  def add_admin
    self.group_members.find_or_create_by({user_id: self.user_id, accepted: true, is_admin: true}).save
  end
end
