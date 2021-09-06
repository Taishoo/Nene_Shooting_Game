extends KinematicBody2D

const type = "BULLET"

var speed = 1000
var velocity = 500
var location = Vector2(0,0)
var damage:int
var state = TRAVEL
var angle:float
var underwater = false
var on_lava = false

const particle = preload("res://Prefabs/Misc/Bubble_Emitter.tscn")
onready var animatedSprite = get_node("AnimatedSprite")
onready var animationPlayer = get_node("AnimationPlayer")

const collisions = ["ENEMY", "BLOCK"]

enum {
	TRAVEL,
	IMPACT,
	DESPAWN,
}

func _ready():
	self.rotation = angle
	
	if underwater and not on_lava:
		var bubbles = particle.instance()
		bubbles.position = self.position
		bubbles.frequency = rand_range(3,5)
		bubbles.area_size = Vector2(50,10)
		bubbles.burst = true
		get_tree().get_current_scene().get_node("World").add_child(bubbles)
	
func _physics_process(delta):
	match state:
		TRAVEL:
			travel(delta)
		IMPACT:
			impact()
		DESPAWN:
			despawn()
	
#================state functions=============

func travel(delta):
	animationPlayer.play("Fire")
	velocity = location * speed 
	velocity = move_and_slide(velocity)
	
func impact():
	animationPlayer.play("Impact")
	
func despawn():
	self.queue_free()
	
#================special functions===========

func _on_Hitbox_body_entered(body):
	if not "type" in body:
		state = IMPACT
		
func impact_finished():
	state = DESPAWN


func _on_Hitbox_area_entered(area):
	var body = area.get_parent()
	
	if "type" in body:
		if collisions.has(body.type) and body.has_method("take_damage"):
			body.take_damage(damage)
			state = DESPAWN

func _on_Timer_timeout():
	state = DESPAWN
