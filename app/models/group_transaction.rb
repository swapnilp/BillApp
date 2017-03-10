class GroupTransaction < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :group_transaction_members
  
end
