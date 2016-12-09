class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
      #@user_followers =current_user.followers
      #@entries = @user_followers[0].entries.paginate(page: params[:page]) 
       @entries = Entry.order("created_at DESC").limit(3).page(params[:page])
  end

  def show
    if logged_in?
      @entries = Entry.find(params[:id])
      @comments = @entries.comments.paginate(page: params[:page])
       if current_user.following.include?(User.find_by id: @entries[:user_id]) || current_user?(User.find_by id: @entries[:user_id])
       @entry  = current_user.entries.build
       @comment = @entry.comments.build
    end
    else
    @entries = Entry.find(params[:id])
    @comments = @entries.comments.paginate(page: params[:page])
    end
  end

  def create
  	@entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  	@entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url
  end

  private

    def entry_params
      params.require(:entry).permit(:title,:body)
    end

    def correct_user
      @micropost = current_user.entry.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
