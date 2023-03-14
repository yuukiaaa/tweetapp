body = "テストの記事です\n\n" + "これはテスト"


0.upto(4) do |idx|
    article = Article.create(
        title: "テストの記事です　#{idx}",
        body: body,
        released_at: 8.days.ago.advance(days: idx),
        expired_at: 2.days.ago.advance(days: idx),
        member_only: (idx % 3 == 0),
        user_id: idx + 1
    )

    if idx == 0 || idx == 1
        %w(saburo shiro).each do |name|
            voter = User.find_by(name: name)
            voter.voted_articles << article
        end
    end

end