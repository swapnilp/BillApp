class GroupTransactionMember < ActiveRecord::Base
  belongs_to :group_transaction, :counter_cache => true
  belongs_to :group_member
  
end
