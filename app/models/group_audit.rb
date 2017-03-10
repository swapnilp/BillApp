class GroupAudit < ActiveRecord::Base

  belongs_to :group
  belongs_to :user

  def au_report 
    members = eval(self.report)
    users = []
    return users if members.nil?
    members.each do |key, value|
      users << {User.where(id: key).last.try(:email) => value }
    end
    return users
  end
  
end
