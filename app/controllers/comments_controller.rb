class CommentsController < ApplicationController

	def create
    @current_post = Entry.find_by id: params[:comment][:id] 
    @comment= @current_post.comments.create! content: params[:comment][:content], user_id: current_user.id
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to entry_url(@current_post)
    else
      render 'static_pages/home'
    end
  end

  def show

  end

  def destroy
    @comments.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  private
   # def current_post
   #    @current_post=Micropost.find_by id: @microposts.id
   # end

    def comment_params
      params.require(:comment).permit(:content, :id)
    end
end
