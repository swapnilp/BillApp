class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :group_members
  has_many :my_groups, through: :group_members, source: :group
  
  validates :mobile,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
end
