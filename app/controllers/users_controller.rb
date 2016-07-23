class UsersController < ApplicationController
	before_filter :authorize
	
	def new
		if current_user.is_admin == 0
  			redirect_to '/' 
  		else
  			@user = User.new
  		end
	end

	def create 
		if current_user.is_admin == 0
  			redirect_to '/' 
  		else
		    @user = User.new(user_params) 
		   	@user.is_admin = 0
		    if @user.save
		      # session[:user_id] = @user.id 
		      redirect_to '/signup'
		      flash[:success] = "Usuário cadastrado no sistema."
		    else 
		      ## add error message
		      redirect_to '/signup' 
		      flash[:error] = "Usuário já está cadastrado no sistema."
		    end 
		end
	end

	def show
		@user = User.find(params[:id]) 
	end

	def list
		if current_user.is_admin == 0
			redirect_to '/'
		else
			@users = User.all		
		end
	end

	def destroy
		if current_user.is_admin == 0
			redirect_to '/'
		else
			@user = User.find(params[:id])
			@user.destroy
			redirect_to '/list'
		end
	end

private

  def user_params
    params.require(:user).permit(:email, :is_admin, :password)
  end
end
