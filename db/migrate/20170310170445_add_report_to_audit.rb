class AddReportToAudit < ActiveRecord::Migration
  def change
    add_column :group_audits, :report, :string
  end
end
