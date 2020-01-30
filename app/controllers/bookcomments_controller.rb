class BookcommentsController < ApplicationController
	before_action :authenticate_user!

def create
	@book = Book.find(params[:book_id])
	@book_new = Book.new
	@bookcomment = @book.bookcomments.new(bookcomment_params)
	@bookcomment.user_id = current_user.id
	if @bookcomment.save
	flash[:success] = "Comment was successfully created."
      redirect_to book_path(@book)
    else
    	flash[:notice] = ' errors prohibited this obj from being saved:'
      @bookcomments = Bookcomment.where(book_id: @book.id)
      render '/books/show'
    end
  end


 def destroy
    @bookcomment = Bookcomment.find(params[:book_id])
    if @bookcomment.user != current_user
      redirect_to request.referer
    end
    @bookcomment.destroy
    redirect_to request.referer
    end


private
def bookcomment_params
	params.require(:bookcomment).permit(:comment)
 end
end