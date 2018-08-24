# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users = User.create!(Array.new(100) { { login: Faker::Internet.username } })
# ips = 50.times.map { Faker::Internet.ip_v4_address }
# Post.create!(
#   Array.new(200_000) { { user: users.sample, ip: ips.sample, title: Faker::Book.title, body: Faker::Lorem.paragraph } }
# )

logins = User.pluck(:login)
ips = Post.select("DISTINCT ip").map(&:ip).map(&:to_s)
ips.take(30).each { |ip| IpUsage.create!(ip: ip, used_by: logins.sample(rand(50))) }