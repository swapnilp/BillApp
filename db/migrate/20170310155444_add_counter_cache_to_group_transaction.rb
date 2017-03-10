class AddCounterCacheToGroupTransaction < ActiveRecord::Migration
  def change
    add_column :group_transactions, :group_transaction_members_count, :integer, default: 0
  end
end
