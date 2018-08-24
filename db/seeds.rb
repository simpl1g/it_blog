# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

logins = Array.new(100) { Faker::Internet.username }
ips = Array.new(50) { Faker::Internet.ip_v4_address }

200_000.times do
  PostCreator.new(login: logins.sample, ip: ips.sample, title: Faker::Book.title, body: Faker::Lorem.paragraph).create_post
end

min_post_id = Post.minimum(:id)
max_post_id = Post.maximum(:id)

200_000.times do
  RankCreator.new(post_id: rand(min_post_id..max_post_id), rank: rand(1..5)).create_rank
end