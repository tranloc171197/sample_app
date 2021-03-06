class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    # fssfd
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t "controllers.microposts.add_success"
      redirect_to request.referrer || root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "controllers.microposts.delete_success"
    else
      flash[:danger] = t "controllers.microposts.delete_fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
