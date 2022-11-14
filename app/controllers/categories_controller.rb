class CategoriesController < ApplicationController

	before_action :require_admin, only: [:create, :new]

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params.require(:category).permit(:name))
		if @category.save
			flash[:notice] = "Category #{@category.name} created successully"
			redirect_to category_path(@category)
		else
			flash[:notice] = "Category #{@category.name} creation failed"
			render 'new'
		end
	end

	def index
		@catgories = Category.paginate(page: params[:page], per_page: 3)
	end

	def show
		@category = Category.find(params[:id])
		@articles = @category.articles
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(params.require(:category).permit(:name))
			flash[:notice] = "Category updated successully"
			redirect_to category_path(@category)
		else
			flash[:notice] = "Category #{@category.name} updation failed"
			render 'edit'
		end
	end


	private
	def require_admin
		if !(logged_in? && current_user.admin?)
			flash[:notice] = "You will not be able to create new category"
			redirect_to categories_path
		end
	end
end