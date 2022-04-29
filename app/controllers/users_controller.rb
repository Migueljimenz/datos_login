class UsersController < ApplicationController
    before_action :authenticate_user!
      
      def index
        authorize User
        @users = User.all
      end
  
      def edit
         authorize User
          @user = User.find(params[:id])
      end
  
      def update
          @user = User.find(params[:id])
          if @user.update(role_params_update)
              redirect_to users_path
          else
              render :edit
          end
      end
  
  
      private
  
      def role_params_update
        params.require(:user).permit({role_ids:[]})
      end
    
    end