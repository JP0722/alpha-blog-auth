class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]

	before_action :check_if_same_user, only: [:edit, :update, :destroy]

	def new
		@user = User.new
	end

	def show
		@articles = @user.articles
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	def create
		@user = User.new(user_params)
		print_debug params
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "User created successfully"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Profile updated successfully"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end


	def destroy
		@user.destroy
		session[:user_id] = nil if @user == current_user
		flash[:notice] = "Account & all related articles successfully deleted"
		redirect_to root_path
	end


	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def print_debug(msg)
		puts "-"*20
		puts "Inside users controller"
		puts msg
		puts "-"*20
	end

	def set_user
		@user = User.find(params[:id])
	end

	def check_if_same_user
		if current_user != @user && !current_user.admin?
			flash[:notice] = "You are not allowed to perform this action.."
			redirect_to users_path
		end
	end


end