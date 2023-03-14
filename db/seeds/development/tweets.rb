ITEM_NUM = 50

names = ['taro', 'jiro', 'saburo', 'shiro', 'goro']
tweets = ['Hello world', 'Good afternoon', 'Hi', 'Hey', 'Nice to see you']
ids = [1, 2, 3, 4, 5]

names_repeat = ITEM_NUM / names.size
tweets_repeat = ITEM_NUM / tweets.size
ids_repeat = ITEM_NUM / ids.size

names = names * names_repeat
tweets = tweets * tweets_repeat
ids = ids * ids_repeat

0.upto(ITEM_NUM) do |idx|
    begin
        Tweet.create!(
            name: names[idx],
            user_id: ids[idx],
            tweet: tweets[idx]
        )
    rescue
        puts "Tweet.createエラー"
    end
end
