class ArticlesController < ApplicationController
    before_action :login_required, except: [:index, :show]

    def index
        @articles = Article.order(released_at: :desc)
        @articles = @article&.open_to_the_public unless current_user
        @articles = @articles&.page(params[:page])&.per(10)
    end

    def show
        articles = Article.all
        articles = article.open_to_the_public unless current_user

        @article = articles.find(params[:id])
    end

    def new
        @user = current_user
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        # render plain: @article.save!
        #render plain: article_params
        if @article.save
            flash[:notice] = "記事を作成しました"
            redirect_to @article
        else
            flash.now[:alert] = "記事を作成できませんでした"
            render :new
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.assign_attributes(article_params)
        if @article.save
            flash[:notice] = "記事を更新しました"
            redirect_to @article
        else
            flash.now[:alert] = "記事を更新できませんでした"
            render :edit
        end
    end

    def like
        @article = Article.find(params[:id])
        @article.voters << current_user
        render 'vote.js.erb'
        #redirect_to @article, notice: "いいね！をしました"
    end

    def unlike
        @article = Article.find(params[:id])
        @article.voters.destroy(current_user)
        render 'unvote.js.erb'
        #redirect_to @article, notice: "いいね！を取り消しました"
    end

    def voted
        @article = current_user.voted_articles.order("votes.created_at DESC").page(params[:page]).per(15)
    end

    private def article_params
        params.require(:article).permit(:title, :body, :released_at, :expired_at, :member_only, :user_id)
    end
end
