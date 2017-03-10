class AddAcceptedToGroupMember < ActiveRecord::Migration
  def change
    add_column :group_members, :accepted, :boolean, default: false
    add_column :group_members, :accepted_at, :datetime
    
  end
end
