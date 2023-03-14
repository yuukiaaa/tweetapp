class Article < ApplicationRecord
    before_validation do
        self.expired_at = nil if @no_expiration
    end

    belongs_to :user
    has_many :images, class_name: "ArticleImage" 
    has_many :votes, dependent: :destroy # votesモデルは「いいね」用の多対多の関連付け
    has_many :voters, through: :votes, source: :user # article.userと重複を避けるため

    validates :title, :body, :released_at, presence: true
    validates :title, length: {maximum: 80}
    validates :body, length: {maximum: 2000}

    def no_expiration
        expired_at.nil?
    end

    def no_expiration=(val)
        @no_expiration = val.in?([true, "1"])
    end


    # scopeはレコードの検索をシンプルに描き表す scope :スコープ名, -> {クエリーメソッド}
    scope :open_to_the_public, -> {where(member_only: false)}
    scope :visible, -> do
        now = Time.current
        where("released_at <= ?", now).where("expired_at > ? OR expired_at IS NULL", now)
    end


end
