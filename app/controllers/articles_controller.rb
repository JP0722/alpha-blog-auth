class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :required_user, except: [:show, :index]
	before_action :required_same_user, only: [:edit, :update, :destroy]

	def show
	end

	def index
		@articles = Article.paginate(page: params[:page], per_page: 3)
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :description, category_ids: []))
		@article.user_id = current_user.id
		if @article.save
			flash[:notice] = "Article created successully"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		if @article.update(params.require(:article).permit(:title, :description, category_ids: []))
			flash[:notice] = "Article updated successully"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end


	private

	def print_debug(args)
		puts "-"*20
		puts args
		puts "-"*20
	end

	def required_same_user
		if (current_user != @article.user_id && !current_user.admin?)
			flash[:notice] = "You are not allowed to perform this action"
			redirect_to articles_path
		end
	end

	def set_article
		@article = Article.find(params[:id])
	end
end