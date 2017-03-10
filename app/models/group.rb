class Group < ActiveRecord::Base
  has_many :group_members
  has_many :group_transactions

  def add_members(members)
    members.each do |mem|
      self.group_members.find_or_create_by({user_id: mem}).save
    end
    
  end
end
