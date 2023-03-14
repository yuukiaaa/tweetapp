class AccountsController < ApplicationController
    before_action :login_required, except: [:new, :create]
    before_action :user_params, only: [:create, :update]

    def show
        @user = current_user
    end

    def new
        @user = User.new
    end

    def create
        # render plain: user_params.inspect
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "アカウントを新規作成しました"
            redirect_to root_path
        else
            flash.now[:alert] = "アカウントを作成できませんでした"
            redirect_to new_account_path
        end

    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.update(user_params)
            flash[:notice] = "変更しました"
            redirect_to show_tweeter_item_path(@user)
        else
            flash[:alert] = "変更できませんでした"
            redirect_to show_tweeter_item_path(@user)
        end
    end

    def destroy
        @user = current_user
        session.delete(:user_id)
        @user.destroy
        flash[:notice] = "アカウントを削除しました。"
        redirect_to root_path
    
    end

    private
    # ストロングパラメータ　params.require(：モデル名).permit(：カラム名、：カラム名)
    def user_params
        params.require(:user).permit(:name, :description, :password, :new_profile_picture, :remove_profile_picture)
    end
end
