extends "res://Scripts/Mob.gd"

const type:String = "ENEMY"

export var points:int = 2

var state = IDLE

var health:int = 5
var max_health:int = health

onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")
onready var animatedSprite = get_node("AnimatedSprite")
onready var bubbles = get_node("Bubble_Emitter")
onready var particles = get_node("Destroy")

enum{
	IDLE,
	FAINT,
}

func _ready():
	add_collision_exception_with(get_tree().get_current_scene().get_node_or_null("World/Nene"))

func _physics_process(delta):
	special_checker()
	match state:
		IDLE:
			idle(delta)
		FAINT:
			faint()

#============state functions============

func idle(delta):
	animationPlayer.play("Idle")
	apply_velocity(delta)

func faint():
	particles.visible = true
	particles.emitting = true
	get_node("CollisionShape2D").disabled = true
	animatedSprite.visible = false
	
	yield(get_tree().create_timer(0.3), "timeout")
	self.queue_free()
#============special functions==========

func special_checker():
	bubbles.emitting = true if underwater and not on_lava else false
	if health <= 0:
		state = FAINT

func apply_velocity(delta):
	var gravity = Global.GRAVITY if not on_water else Global.GRAVITY * 0.05
	self.velocity.y = self.velocity.y + gravity
	velocity = move_and_slide(velocity * delta * 60, Vector2.UP)

func take_damage(damage):
	animatedSprite.set_modulate(Color(255,0,0,1))
	health -= damage

	yield(get_tree().create_timer(0.1), "timeout")
	animatedSprite.set_modulate(Color(1,1,1,1))

#=================sensor / event functions====
