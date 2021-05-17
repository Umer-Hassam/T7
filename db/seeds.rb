# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# MOVE EFFECTS
MoveEffect.create(name: 'Launch')
MoveEffect.create(name: 'KND (Face Up Feet towards)')
MoveEffect.create(name: 'KND (Face Down Feet towards)')
MoveEffect.create(name: 'KND(Face Up Feet away)')
MoveEffect.create(name: 'KND (Face Down Feet away)')
MoveEffect.create(name: 'Force Crouch')
MoveEffect.create(name: 'Force Back Turned')
MoveEffect.create(name: 'Jails')


Purpose.create(name: "Punisher")
Purpose.create(name: "Pressure")
Purpose.create(name: "Tech Trap")
Purpose.create(name: "Frame Trap")
Purpose.create(name: "Mixup")
Purpose.create(name: "i10 Punish")

Property.create(name: "Evasive", description: "#0EF")
Property.create(name: "High Crush", description: "#0EF")
Property.create(name: "Homming", description: "#CCF")
Property.create(name: "Armor", description: "#E44")
Property.create(name: "Wall Splat", description: "#fc7")
Property.create(name: "Wall Bounce", description: "#fc7")	
Property.create(name: "Screw", description: "#4D8")
Property.create(name: "Tracks Left", description: "")
Property.create(name: "Tracks Right", description: "")
Property.create(name: "Tracks Both", description: "")

Character.create(name:"Lei Wulong", 
full_image_link:"https://i.pinimg.com/originals/e4/31/9c/e4319cf72216fc58407b8317d42a6f01.jpg", 
thumb_image_link:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRwRb_JaaIHfHe8sHIxUhlMwO8Lwi71BZbuug&usqp=CAU")

Character.create(name:"Anna Williams", 
thumb_image_link:"https://bleedingcool.com/wp-content/uploads/2018/08/Tekken-7-Anna-Williams.jpg")

#
# MOVE TYPES
#MoveEffect.create(name: 'Screw')
#MoveEffect.create(name: 'Armor')