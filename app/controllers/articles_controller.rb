class ArticlesController < ApplicationController


	def show
		@article = Article.find(params[:id])
	end

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :description))
		if @article.save
			flash[:notice] = "Article created successully"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(params.require(:article).permit(:title, :description))
			flash[:notice] = "Article updated successully"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		puts 'came to destroy'
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end


	private

	def print_debug(args)
		puts "-"*20
		puts args
		puts "-"*20
	end
end