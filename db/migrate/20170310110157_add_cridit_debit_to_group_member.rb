class AddCriditDebitToGroupMember < ActiveRecord::Migration
  def change
    add_column :group_members, :balance, :float, default: 0
  end
end
