extends "res://Scripts/Mob.gd"

const type = "PLAYER"
var walk_speed = 300
const JUMP_FORCE = -900
var state = START
var can_fire = true

var on_water:bool = false
var underwater:bool = false
var on_lava:bool = false

var velocity:Vector2 = Vector2(0,0)


var just_jumped = false
var mouse_position = Vector2(0,0)

onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")
onready var animatedSprite = get_node("AnimatedSprite")
onready var coolDown = get_node("Cooldown")
onready var bubbles = get_node("Bubble_Emitter")
onready var ui = get_tree().get_current_scene().get_node_or_null("CanvasLayer")

enum {
	IDLE,
	WALK,
	FAINT,
	JUMP,
	FALL,
	START,
}

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	special_checkers()
	movement(delta)
	
	match state:
		IDLE:
			idle()
		WALK:
			walk()
		JUMP:
			jump()
		FAINT:
			faint()
		FALL:
			fall()
		START:
			start()
	
#================State functions=================

func start():
	animationPlayer.play("Start")

func idle():
	if not just_jumped:
		animationPlayer.play("Idle" if is_on_floor() else "Fall")
	
func walk():
	if not just_jumped:
		animationPlayer.play("Walk" if is_on_floor() else "Fall")
	
func jump():
	self.velocity.y = JUMP_FORCE
	just_jumped = true
	animationPlayer.play("Jump")
	
func faint():
	animationPlayer.play("Faint")
	
func fall():
	animationPlayer.play("Fall")
	
#===================Special functions============

func special_checkers():
	#flip sprite for aiming
	if self.get_position().x > get_global_mouse_position().x:
		animatedSprite.set_flip_h(true)
	else:
		animatedSprite.set_flip_h(false)
	
	bubbles.emitting = true if underwater and not on_lava else false

func movement(delta):
	var gravity = Global.GRAVITY if not on_water else Global.GRAVITY * 0.05
	var move_speed = walk_speed if not on_water else walk_speed * 0.5
	
	if Input.is_action_just_pressed("fire") and can_fire:
		shoot()
	
	# regular jump
	if Input.is_action_pressed("jump") and is_on_floor() and not on_water:
		state = JUMP
	
	# jump on water (swim)
	elif Input.is_action_pressed("jump") and on_water:
		self.velocity.y = -move_speed
	
	# sink on water
	elif Input.is_action_pressed("crouch") and on_water:
		self.velocity.y = move_speed
	
	# move left
	elif Input.is_action_pressed("walk_left"):
		self.velocity.x = -move_speed
		state = WALK
	
	# move right
	elif Input.is_action_pressed("walk_right"):
		self.velocity.x = move_speed
		state = WALK
			
	else:
		self.velocity.x = 0
		state = IDLE
	
	self.velocity.y = self.velocity.y + gravity
	
	velocity = move_and_slide(velocity * delta * 60, Vector2.UP)

func shoot():
	if PlayerStats.WEAPON.name == "Handgun":
		var bullet = preload("res://Prefabs/Nene_Bullet.tscn")
		var projectile = bullet.instance()
		var L_Roffset = -50 if animatedSprite.flip_h else 50
		var final_position = get_global_mouse_position() - Vector2(0,-50)
		
		projectile.on_lava = self.on_lava
		projectile.angle = get_angle_to(final_position)
		projectile.damage = PlayerStats.WEAPON.damage
		projectile.location = setAngleVector(final_position)
		projectile.underwater = self.underwater
		projectile.position = self.get_position() + Vector2(L_Roffset,-50)
		get_tree().get_current_scene().get_node("World").add_child(projectile)
		coolDown.start(PlayerStats.WEAPON.cooldown)
		can_fire = false
			
func take_damage(damage):
	PlayerStats.health -= damage

	if not ui == null:
		ui.animate_health()
	
func setAngleVector(targetPosition):
	var angle = get_angle_to(targetPosition)
	return Vector2(cos(angle), sin(angle))
	
#=================Sensor / Event Functions=================

func start_animation_finished():
	state = IDLE

func jump_animation_finished():
	just_jumped = false

func _on_Cooldown_timeout():
	coolDown.stop()
	can_fire= true
