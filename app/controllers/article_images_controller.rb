class ArticleImagesController < ApplicationController
    before_action :login_required

    before_action do
        # ブラウザから/articles/123/images/99のようなパスにアクセスがあると
        # railsはarticle_idに123、idに99という文字列をセットする
        @article = current_user.articles.find(params[:article_id])
    end

    def index
        @images = @article.images.order(:id)
    end

    def show
        redirect_to action: "edit"
    end

    def new
        @image = @article.images.build # buildはnewと同じ
    end

    def edit
        @image = @article.images.find(params[:id])
    end

    def create
        @image = @article.images.build(image_params)
        if @image.save
            redirect_to [@article, :images], notice: "画像を作成しました"
        else
            render "new"
        end
    end

    def update
        @image = @article.images.find(params[:id])
        @image.assign_attributes(image_params)
        if @image.save
            redirect_to [@article, :images], notice: "画像を更新しました"
        else
            render "edit"
        end
    end

    def destroy
        @image = @article.images.find(params[:id])
        @image.destroy
        redirect_to [@article, :images], notice: "画像を削除しました"
    end

    private
    def image_params
        params.require(:article_image).permit(
            :new_data,
            :alt_text
        )
    end
    
end
