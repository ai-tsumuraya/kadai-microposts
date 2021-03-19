class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save 
      flash[:success] = 'Your Message has been posted successfully.'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "Could'nt post the message."
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Your message has been deleted successfully.'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost 
      redirect_to root_url
    end
  end
end
