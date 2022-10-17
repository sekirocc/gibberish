# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'digest/md5'

username = 'testuser'
pass_hash = Digest::MD5.hexdigest("foobar")
birth = DateTime.new(1990, 1, 1)

member_day = DateTime.new(2022, 1, 1)

user = User.create({
    nickname: username,
    birthday: birth,
    gender: 0,
    status: 0,
    username: username,
    password_hash: pass_hash,
    email: "chenjie@chenjie.com",
    email_confirmed: true,
    mobile: 18111111111,
    wechat: "18111111111",
    weibo: "18111111111",
    avatar_url: "www.avatar.com/" + username,
    member_since: member_day,
})

murmur = Murmur.create({
                content: "this is the first murmur",
                user_id: user.id
              })

