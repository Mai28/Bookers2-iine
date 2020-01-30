class BookcommentsController < ApplicationController
def create
	@book = Book.find(params[:book_id])
	comment = Bookcomment.new(bookcomment_params)
	comment.book_id = @book.id
	comment.user_id = current_user.id
	comment.save
	redirect_to  books_path
end


private
def bookcomment_params
	params.require(:bookcomment).permit(:comment)
 end
end