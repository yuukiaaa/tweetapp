class User < ApplicationRecord
    has_secure_password # Userクラスにpassword, password_confirmationの2つの属性が追加される
    has_many :tweets, dependent: :destroy
    has_many :articles, dependent: :destroy
    has_many :votes, dependent: :destroy # 多対多の関連付け　記事の「いいね」機能の実装
    has_many :voted_articles, through: :votes, source: :article # user.articleメソッドで重複を避けるため　user.votes

    has_one_attached :profile_picture
    attribute :new_profile_picture
    attribute :remove_profile_picture, :boolean

    before_save do
        if new_profile_picture
            self.profile_picture = new_profile_picture
          
        elsif remove_profile_picture
            self.profile_picture.purge
        end
    end

    validate if: :new_profile_picture do
        if new_profile_picture.respond_to?(:content_type)
            unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
                errors.add(:new_profile_picture, :invalid_image_type)
            end
        else
            errors.add(:new_profile_picture, :invalid)
        end
    end

    # 他の人が投稿した記事にいいねを押せるかどうかを判定
    def votable_for?(article)
        article && article.user != self && !votes.exists?(article_id: article.id)
    end

    # クラスメソッドの定義　class << self で User.search()が使えるようになる
    class << self 
        def search(query)
            rel = order("id")
            if query.present?
                rel = rel.where("name LIKE ?", "%#{query}%")
            end
            rel
        end
    end
end
