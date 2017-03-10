class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.references :group, null: false
      t.references :user, null: false
      t.boolean :is_admin, null: false, default: false
      t.timestamps null: false
    end
  end
end
