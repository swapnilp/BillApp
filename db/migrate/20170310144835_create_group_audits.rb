class CreateGroupAudits < ActiveRecord::Migration
  def change
    create_table :group_audits do |t|
      t.references :group
      t.references :user
      t.timestamps null: false
    end
  end
end
