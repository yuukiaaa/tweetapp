class ItemsController < ApplicationController
    before_action :tweet_params, only: [:create]

    def index
        @tweet = Tweet.new
        @tweets = Tweet.includes(:user).order(created_at: "DESC").page(params[:page]).per(10)
    end

    def new
        @tweet = Tweet.new
    end

    def show
    end

    def create
        #render plain: tweet_params[:tweet].inspect
        user_name = current_user.name
        user_id = current_user.id
        @tweet = Tweet.new(name: user_name, user_id: user_id, tweet: tweet_params[:tweet])
        if @tweet.save
            flash[:notice] = "ツイートしました"
            redirect_to items_path
       else
            flash.now[:alert] ="ツイートに失敗ました"
            redirect_to items_path
       end
    end

    def edit
    end

    def update
    end

    def destroy
        if current_user
            @tweet = Tweet.find(params[:id])
            @tweet.destroy
            flash[:notice] = "削除しました"
            redirect_to items_path
        end
    end

    def show_tweeter
        #render plain: params.inspect
        @user = User.find(params[:id])
    end

    private
    def tweet_params
        # require(モデル名)、permitはストロングパラメータ
        params.require(:tweet).permit(:name, :tweet)
    end
end
