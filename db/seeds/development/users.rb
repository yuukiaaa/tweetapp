names = ['taro', 'jiro', 'saburo', 'shiro', 'goro']
description = ['I love a dog.', 'I have a pen.', 'I go to Japan.', 'I eat an apple.', 'I need a computer.']

pic_filename = "picture.jpg"
pic_path = Rails.root.join(__dir__, pic_filename)

0.upto(4) do |idx|
    if idx == 0
        user = User.create(
            name: names[idx],
            description: description[idx],
            administrator: true,
            password: 'test'

        )
    else
        user = User.create(
            name: names[idx],
            description: description[idx],
            password: 'test'
        )
    end

    File.open(pic_path) do |f|
        user.profile_picture.attach(io: f, filename: pic_filename)
    end
end