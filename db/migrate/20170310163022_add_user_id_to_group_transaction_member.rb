class AddUserIdToGroupTransactionMember < ActiveRecord::Migration
  def change
    add_column :group_transaction_members, :user_id, :integer
  end
end
