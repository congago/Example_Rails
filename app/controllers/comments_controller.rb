class CommentsController < ApplicationController

	def create
    @current_post = Micropost.find_by id: params[:comment][:id] 
    @comment= @current_post.comments.create! content: params[:comment][:content] 
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to 'comments#show'
    else
      render 'static_pages/home'
    end
  end

  def show
     #@comments = Comment.find_by(micropost: params[:id])
     #@comments = @microposts.comment.paginate(page: params[:page])
     #@micropost  = current_user.microposts.build
     #@comment = @micropost.comments.build
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
