class User < ApplicationRecord

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          has_one_attached :avatar

          after_create_commit :add_default_avatar, on: %i[update]
          def avatar_thumbnail
            if avatar.attached?
              avatar.variant(resize_to_limit: [65, 65]).processed
            else
              "/default_profile.webp"
            end
          end

          private

          def add_default_avatar
            unless avatar.attached?
              avatar.attach(
                io: File.open(
                  Rails.root.join(
                    'app','assets','images','default_profile.webp'
                  )
                ),
                filename: 'default_profile.webp',
                content_type: 'image/webp'
              )
          end   
        end
        

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
