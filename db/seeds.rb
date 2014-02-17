# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all

Product.create(name: 'A Dead Parrot', price: 105.95)

Product.create(name: 'A Slug That Talks (Not Really)', price: 30.00)

Product.create(name: 'Spiny Norman The Hedgehog', price: 79.95)

Product.create(name: 'A Confused Cat', price: 40.00)

Status.delete_all

Status.create(status_type: 'DRAFT')

Status.create(status_type: 'PLACED')

Status.create(status_type: 'PAID')

Status.create(status_type: 'CANCELLED')