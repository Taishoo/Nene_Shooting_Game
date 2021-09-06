extends AnimatedSprite

var current_value = 0

const bomb = preload("res://Prefabs/Misc/Explosion.tscn")

func _ready():
	pass


func start_animation():
	get_node("Bomb").play("Tick")

func blink():
	if current_value == 0:
		self.material.set_shader_param("whitening",0.5)
		current_value = 0.5
	else:
		self.material.set_shader_param("whitening",0)
		current_value = 0

	yield(get_tree().create_timer(0.15), "timeout")
	blink()

#===============sensor/event functions==============

func animation_finished():
	var explosion = bomb.instance()
	explosion.scale.x = 4
	explosion.scale.y = 4
	explosion.damage = get_parent().damage
	explosion.position = get_parent().get_position()
	get_tree().get_current_scene().get_node("World").add_child(explosion)
