class CreateGroupTransactions < ActiveRecord::Migration
  def change
    create_table :group_transactions do |t|
      t.references :user
      t.references :group
      t.float :amount, null: false, default: 0.0
      t.string :reason
      t.boolean :all_group, null: false, default: true
      t.timestamps null: false
    end
  end
end
