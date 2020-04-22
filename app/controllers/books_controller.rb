class BooksController < ApplicationController
	before_action :authenticate_user!

	def create
		@book_new = Book.new(book_params)
		@book_new.user_id = current_user.id
		if @book_new.save
		   redirect_to book_path(@book_new.id),notice: 'You have creatad book successfully.'
		else
			@books= Book.all
			@user = current_user
			render :index
		end
	end
	def index
		@book_new = Book.new
		@books = Book.all
		@user = current_user
	end
	def show
		@book = Book.find(params[:id])
		@book_new = Book.new
		@user = User.find(@book.user.id)
	end
	def edit
		@book = Book.find(params[:id])
		redirect_to books_path unless @book.user == current_user
	end
	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   redirect_to book_path(@book),notice: 'Book was successfully updated.'
		else
			render :edit
		end
    end
    def destroy
    	@book = Book.find(params[:id])
    	@book.destroy
    	redirect_to books_path
    end

	private
	def book_params
	  params.require(:book).permit(:title, :body, :user_id)
	end
end