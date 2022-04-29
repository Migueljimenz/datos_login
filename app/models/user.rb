class User < ApplicationRecord

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_create :assign_default_role

  validate :must_have_a_role, on: :update
  
  private 

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "debe tener por lo menos 1 rol")
    end 
  end



  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end

  

end
