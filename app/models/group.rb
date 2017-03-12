class Group < ActiveRecord::Base
  has_many :group_members
  has_many :group_transactions
  has_many :group_audits

  validates :name, uniqueness: { scope: :user_id,
    message: "should happen once per user" }

  after_create :add_admin

  def add_members(members)
    members.each do |mem|
      self.group_members.find_or_create_by({user_id: mem}).save
    end
    
  end

  def add_admin
    self.group_members.find_or_create_by({user_id: self.user_id, accepted: true, is_admin: true}).save
  end

  def make_audit(user_id)
    last_audit = self.group_audits.last.try(:created_at)
    
    members = self.group_members.collect{|gm| {gm.user_id => 0}}.reduce Hash.new, :merge
    members_size = members.size
    group_transactions  = self.group_transactions
    group_transactions = group_transactions.where("created_at > ?", last_audit) if last_audit.present?
    group_transactions.each do |gt|
      next if gt.amount < 1
      if gt.all_group
        amount = (gt.amount / members_size)
        my_amt = ((gt.amount / members_size) * (members_size - 1))
        members.each do |key, value|
          if key == gt.user_id
            members[key] = value + my_amt
          else
            members[key] = value - amount
          end
        end
      else
        if gt.group_transaction_members_count > 1
          amount = gt.amount / (gt.group_transaction_members_count)
          my_amt = (gt.amount / (gt.group_transaction_members_count)) * (gt.group_transaction_members_count - 1)
          gt.group_transaction_members.each do |gtm|
            if gtm.user_id == gt.user_id
              members[gtm.user_id] = members[gtm.user_id] + my_amt
            else
              members[gtm.user_id] = members[gtm.user_id] - amount
            end
          end
        else
          members[gt.user_id] = members[gt.user_id] + gt.amount 
        end
      end
      
    end
    
    self.group_audits.new({user_id: user_id, report: members.to_s}).save
    members.each do |key, value|
      self.group_members.where(user_id: key).update_all({balance: value})
    end
  end
end
