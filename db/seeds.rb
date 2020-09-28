

User.create(username:'Matt', password: 'Noodle1')
User.create(username:'Ajak', password: '123')

Character.create(name: "Benjamin", user_id: 1)
Character.create(name: 'Lily', user_id: 2)
Character.create(name: 'Groggy', user_id: 3)
Character.create(name: 'Pauly', user_id: 3)

Item.create(name: "Knife", description: "Stabby Stabby")
Item.create(name: "Hat", description: "Fancy Wear")
Item.create(name: "Key", description: "Basic Brass Key")
Item.create(name: "Book", description: "All the pages are torn out")
Item.create(name: "Pencil", description: "The tip is broken")

Save.create(character_id: 1, item_id: 1, item_used?: false)
Save.create(character_id: 1, item_id: 3, item_used?: false)
Save.create(character_id: 1, item_id: 5, item_used?: false)
Save.create(character_id: 2, item_id: 2, item_used?: false)
Save.create(character_id: 2, item_id: 4, item_used?: false)
Save.create(character_id: 3, item_id: 1, item_used?: false)
Save.create(character_id: 3, item_id: 2, item_used?: false)
Save.create(character_id: 4, item_id: 5, item_used?: false)

Escape.create(name: "Dungeon", where_am_i: "Cage")
Escape.create(name: "Dungeon", where_am_i: "Bookcase")
Escape.create(name: "Dungeon", where_am_i: "Desk")
Escape.create(name: "Dungeon", where_am_i: "Key Rack")

## entries for escape_id to hit save file
Save.create(character_id: 1, escape_id: 1)
Save.create(character_id: 2, escape_id: 2)
Save.create(character_id: 3, escape_id: 3)
Save.create(character_id: 4, escape_id: 4)


