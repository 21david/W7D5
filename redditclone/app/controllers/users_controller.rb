class UsersController < ApplicationController
    before_action :ensure_logged_out, only: [:new, :create]
    before_action :ensure_logged_in, only: [:index, :show]

    def index
        @users = User.all 
        render :index
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def new
        # @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end