class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :user
      t.string :name
      t.string :reason
      t.timestamps null: false
    end
  end
end
