# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Block.create!(
  block_height: "365715",
  block_hash: "0000000000000000058a92e706c8e80ca6bef42f9e37d1b9bb1c39c0d2aa075b",
  date_posted: Date.today.to_datetime )
