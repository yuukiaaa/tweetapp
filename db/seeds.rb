=begin
table_names = %w(tweets)
table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end
=end

# 順番に注意、usersデータベースを作成してからbelongs_toのtweetsデータベースを作成する
require Rails.root.join("db/seeds", Rails.env, "users" + ".rb")
require Rails.root.join("db/seeds", Rails.env, "tweets" + ".rb")
require Rails.root.join("db/seeds", Rails.env, "articles" + ".rb")