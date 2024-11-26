# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 生成四个User 杜启嵘 石通 杨可清 黄镇
["dqr", "st", "ykq", "hz"].each do |name|
  User.find_or_create_by!(name: name, email: "#{name}@example.com") do |user|
    user.password = "#{name}123"
    user.password_confirmation = "#{name}123"
    user.url = "path/to/default/avator"
  end
end

# 生成四个Commodity 可乐 鸡腿 面包 台灯
["cola", "chiken", "bread"].each do |name|
  Commodity.find_or_create_by!(name: name, price: 10, introduction: "It is of good taste", business_id: 1, url: "path/to/default/homepage", exist: true, category: "food")
end

["lamp"].each do |name|
  Commodity.find_or_create_by!(name: name, price: 10, introduction: "It is of good usage", business_id: 1, url: "path/to/default/homepage", exist: true, category: "furniture")
end