class GroupTransaction < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :group_transaction_members
  
  attr_accessor :members
  
  def add_members(members)
    members.each do |key, value|
      self.group_transaction_members.find_or_create_by({group_member_id: key, user_id: value}).save
    end
  end
end
