# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

List.delete_all
ListItem.delete_all

list = List.create(title: 'My Café List',
description: 'Check out my list of awesome cafées')

ListItem.create(title: 'Café Linne',
description: 'This is a quaint fancy cafe in Uppsala.',
adress: 'Linnégatan 46, 752 63 Uppsala, Sweden',
list_id: list.id)

ListItem.create(title: 'Café Storken',
description: 'A rather busy café',
adress: 'Storgatan 4, 750 60 Uppsala, Sweden',
list_id: list.id)

ListItem.create(title: 'Café Hugo',
description: "A small café with a vegan or hippie crowd. It got low prices and coffee sorts you don't normally find in cafées.",
adress: 'Storgatan 7, 750 60 Uppsala, Sweden',
list_id: list.id)

ListItem.create(title: 'Café Ofvandahls',
description: "An old really quaint café from 1870 and it still got it's original tapestry. It has the feel as though it has not changed the last one and a half century.",
adress: 'Studentgatan 17, 750 20 Uppsala, Sweden',
list_id: list.id)

ListItem.create(title: "Café Hugo's is parken",
description: "Similar to Café Hugo but in the park near the business studies building, Ekonomikum adjacent to Biotopia.",
adress: 'Ekoparken, 750 10 Uppsala, Sweden',
list_id: list.id)

list = List.create(title: 'My List of Delicious Beers',
description: 'Beer list')

ListItem.create(title: 'Heinecken',
description: 'A rather standard beer!',
adress: '',
list_id: list.id)