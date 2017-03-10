class CreateGroupTransactionMembers < ActiveRecord::Migration
  def change
    create_table :group_transaction_members do |t|
      t.references :group_transaction
      t.references :group_member
      t.float :amount, null: false, default: 0.0
      t.timestamps null: false
    end
  end
end
