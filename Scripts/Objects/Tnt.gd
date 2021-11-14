extends "res://Scripts/Mob.gd"

const type = "BLOCK"

var damage = 10
var health = 1
var max_health = health

var current_value = 0
var active = false

const bomb = preload("res://Prefabs/Misc/Explosion.tscn")
onready var animationPlayer = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

func _physics_process(delta):
	if active:
		apply_velocity(delta)


func blink():
	if current_value == 0:
		sprite.material.set_shader_param("whitening",0.5)
		current_value = 0.5
	else:
		sprite.material.set_shader_param("whitening",0)
		current_value = 0

	yield(get_tree().create_timer(0.15), "timeout")
	blink()

func take_damage(_damage):
	if not active:
		active = true
		start_animation()
	
func start_animation():
	animationPlayer.play("Tick")

func apply_velocity(delta):
	var gravity = Global.GRAVITY
	self.velocity.y = self.velocity.y + gravity
	velocity = move_and_slide(velocity * delta * 60, Vector2.UP)

#===============sensor/event functions==============

func animation_finished():
	var explosion = bomb.instance()
	explosion.scale.x = 4
	explosion.scale.y = 4
	explosion.damage = damage
	explosion.position = self.get_position() + Vector2(24,24)
	get_tree().get_current_scene().get_node("World").add_child(explosion)
	self.queue_free()
