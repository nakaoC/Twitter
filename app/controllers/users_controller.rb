class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :like_notes, :following, :followers]

  before_action :correct_user, only: [:edit,:update]

  include ApplicationHelper
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @notes = @user.notes #ユーザーidに対応したuser_idカラムを持っているnoteを取り出す
    @title = "投稿一覧"
  end

  # GET /users/1/edit
  def edit
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_notes
    @notes = @user.like_notes
    @title = "いいね一覧"

    render :show
  end

  def following
    @title = "フォロー"
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end

    def correct_user #ログイン中のユーザーと、アクセスしたページのユーザーが異なる場合はrootバスにリダイレクト
      user = User.find(params[:id])
      if !current_user?(user)
        redirect_to root_path
      end
    end
end
