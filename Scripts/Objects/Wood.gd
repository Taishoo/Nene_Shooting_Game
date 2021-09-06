extends StaticBody2D

const type = "BLOCK"
const sub_type = "WOOD"

var health = 5
var max_health = health
onready var particles = get_node("Destroy")
onready var sprite = get_node("Sprite")

func _ready():
	pass
	
func _physics_process(delta):
	special_checker()
	
#============special functions==============

func special_checker():
	if health <= 0:
		destroy()

func take_damage(damage):
	
	sprite.set_modulate(Color(255,0,0,1))
	health -= damage

	yield(get_tree().create_timer(0.1), "timeout")
	sprite.set_modulate(Color(1,1,1,1))
	
func destroy():
	particles.visible = true
	particles.emitting = true
	get_node("CollisionShape2D").disabled = true
	get_node("Sprite").visible = false
	
	yield(get_tree().create_timer(0.3), "timeout")
	self.queue_free()

#========sensor/event functions=============

func _on_Hurtbox_area_entered(area):
	# var body = area.get_parent()
	
	# if "type" in body:
	# 	if body.type == "BULLET":
	# 		take_damage(body.damage)
	# 		body.state = body.DESPAWN
	pass
