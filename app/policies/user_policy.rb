class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :current_user, :user

    def initialize(current_user, user)
      @current_user  = current_user
      @user = user
    end

    def resolve
      if current_user.has_role? :admin
        user.all
      else
        user.where(location.current_user)
      end
    end
  end

  def index? 
    return true if user.has_role? :admin
  end

  def update?
    return true if user.has_role? :admin
  end
  
  def destroy?
    return true if user.has_role? :admin
  end

end

#   attr_reader :current_user, :user
  
#   def initialize(current_user, user)
#     @current_user = current_user
#     @user = user
#   end
  
#   def index
#     current_user.has_role? :admin  
#   end 
  

  






  
