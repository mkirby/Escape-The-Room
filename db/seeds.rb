
User.create(username:'Matt', password: 'Noodle1')
User.create(username:'Ajak', password: '123')

Character.create(name: "Benjamin", user_id: 1)
Character.create(name: 'Lily', user_id: 2)
Character.create(name: 'Groggy', user_id: 3)
Character.create(name: 'Pauly', user_id: 3)

Item.create(name: "Ring of Keys", description: "A ring of worn brass keys")
Item.create(name: "Cue Stick", description: "A old pool cue stick")
Item.create(name: "Key", description: "Shiny Brass Key")
Item.create(name: "Journal", description: "All the pages are torn out")
Item.create(name: "Bible", description: "A old King James Bible with the words Fish, Fowl, and Cattle highlighted")
Item.create(name: "Pool Ball", description: "The 8 Ball")
Item.create(name: "Scalpel", description: "A recently bloodied scalpel")
Item.create(name: "Polaroids", description: "Polaroid photos of mutilated victims")

Record.create(character_id: 1, item_id: 1, item_used?: false)
Record.create(character_id: 1, item_id: 3, item_used?: false)
Record.create(character_id: 1, item_id: 5, item_used?: false)
Record.create(character_id: 2, item_id: 2, item_used?: false)
Record.create(character_id: 2, item_id: 4, item_used?: false)
Record.create(character_id: 3, item_id: 1, item_used?: false)
Record.create(character_id: 3, item_id: 2, item_used?: false)
Record.create(character_id: 4, item_id: 5, item_used?: false)

Escape.create(name: "Dungeon", where_am_i: "Cage")
Escape.create(name: "Dungeon", where_am_i: "Bookcase")
Escape.create(name: "Dungeon", where_am_i: "Desk")
Escape.create(name: "Dungeon", where_am_i: "Key Rack")

## entries for escape_id to hit save file
Record.create(character_id: 1, escape_id: 1)
Record.create(character_id: 2, escape_id: 2)
Record.create(character_id: 3, escape_id: 3)
Record.create(character_id: 4, escape_id: 4)


