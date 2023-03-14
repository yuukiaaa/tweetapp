class Admin::AccountsController < Admin::Base
    before_action :admin_login_required
    before_action :user_params, only: [:create, :update]

    def index
        @user = User.new
        @users = User.all.page(params[:page]).per(30)
    end

    def show
        @user = User.find(:id)
    end

    def new
        @user = User.new
    end

    def create
        # render plain: user_params.inspect
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "アカウントを新規作成しました"
            redirect_to admin_root_path
        else
            flash.now[:alert] = "アカウントを作成できませんでした"
            redirect_to new_admin_account_path
        end

    end

    def edit
        @user = User.find(params[:id])
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
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "アカウントを削除しました。"
        redirect_to admin_root_path
    end

    def search
        @users = User.search(params[:query])
        render "index"
    end


    private
    # ストロングパラメータ　params.require(：モデル名).permit(：カラム名、：カラム名)
    def user_params
        params.require(:user).permit(:name, :description, :password, :new_profile_picture, :remove_profile_picture)
    end

end
