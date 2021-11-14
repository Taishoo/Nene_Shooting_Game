extends "res://Scripts/Mob.gd"

const type:String = "ENEMY"

export var patrol_area:Vector2 = Vector2(200,200)
export var points:int = 2

var walk_speed = 150
const JUMP_FORCE = -400
var state = PATROL

var damage = 12
var health = 10
var max_health = health

var patrol_start_pos

var just_patrolled = false
var current_patrol_travel = LEFT

onready var jump_sensor = get_node("Sensors/JumpSensor")
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")
onready var animatedSprite = get_node("AnimatedSprite")
onready var wait_timer = get_node("Timers/PatrolTimer")
onready var bubbles = get_node("Bubble_Emitter")
onready var particles = get_node("Destroy")

enum{
	IDLE,
	PATROL,
	CHASE,
	FAINT,
	FALL,
	EXPLODE,
}

enum{
	LEFT,
	RIGHT,
}

func _ready():
	#ignore nene's collision
	add_collision_exception_with(get_tree().get_current_scene().get_node_or_null("World/Nene"))
	patrol_start_pos = self.get_position()

func _physics_process(delta):
	special_checker()
	match state:
		IDLE:
			idle(delta)
		PATROL:
			patrol(delta)
		CHASE:
			chase(delta)
		FAINT:
			faint()
	
#===============state functions================

func idle(delta):
	animationPlayer.play("Idle" if is_on_floor() else "Fall")
	apply_velocity(delta)
	
func patrol(delta):
	animationPlayer.play(("Walk" if velocity.x != 0 else "Idle") if is_on_floor() else "Fall")
	var destination

	if not just_patrolled:

		if current_patrol_travel == LEFT:
			destination = patrol_start_pos + (-patrol_area)

		elif current_patrol_travel == RIGHT:
			destination = patrol_start_pos + patrol_area
		
		var move_direction = calculate_chase_vector(self.get_position(), destination, walk_speed)
		self.velocity.x = move_direction if not on_water else move_direction * 0.5
		set_flip(move_direction)
		
		# wait if mob stopped moving
		if self.velocity.x == 0:
			wait_timer.start(rand_range(2,4))
			state = IDLE

	apply_velocity(delta)

func chase(delta) -> void:
	animationPlayer.play("Walk" if velocity.x != 0 else "Idle")
	var player = get_tree().get_current_scene().get_node_or_null("World/Nene")
	var chase_direction = calculate_chase_vector(self.get_position(), player.get_position(), walk_speed)
	var vertical_direction = calculate_vertical_vector(self.get_position(), player.get_position(), walk_speed)

	self.velocity.x = chase_direction if not on_water else chase_direction * 0.5

	if on_water:
		self.velocity.y = vertical_direction * 0.5

	set_flip(chase_direction)
	apply_velocity(delta)

func faint() -> void:
	particles.visible = true
	particles.emitting = true
	get_node("CollisionShape2D").disabled = true
	animatedSprite.visible = false
	
	yield(get_tree().create_timer(0.3), "timeout")
	self.queue_free()
	
#===============special functions===============

func set_flip(direction):
	animatedSprite.set_flip_h(true if direction < 1 else false)
	jump_sensor.scale.x = -1 if direction < -1 else 1

func apply_velocity(delta):
	var gravity = Global.GRAVITY if not on_water else Global.GRAVITY * 0.05
	self.velocity.y = self.velocity.y + gravity
	velocity = move_and_slide(velocity * delta * 60, Vector2.UP)

func special_checker():
	bubbles.emitting = true if underwater and not on_lava else false

	if state != CHASE and on_water:
		floatup()
	
	if health <= 0:
		state = FAINT

func take_damage(dmg):
	animatedSprite.set_modulate(Color(255,0,0,1))
	health -= dmg
	state = CHASE

	yield(get_tree().create_timer(0.1), "timeout")
	animatedSprite.set_modulate(Color(1,1,1,1))

func jump():
	self.velocity.y = JUMP_FORCE

func floatup():
	self.velocity.y = -walk_speed

func set_patrol_travel():
	if current_patrol_travel == LEFT:
		current_patrol_travel = RIGHT
	else:
		current_patrol_travel = LEFT
	
#==============sensor/event functions============

func _on_PatrolTimer_timeout():
	if state == IDLE:
		wait_timer.stop()
		set_patrol_travel()
		state = PATROL

func _on_Vision_body_entered(body):
	if "type" in body:
		if body.type == "PLAYER":
			state = CHASE

func _on_Vision_body_exited(body):
	if "type" in body:
		if body.type == "PLAYER":
			patrol_start_pos = self.get_position()
			state = PATROL

func _on_JumpSensor_body_entered(body):
	if "type" in body and is_on_floor():
		if not collision_ignore.has(body.type):
			jump()
	elif is_on_floor():
		jump()

func _on_Trigger_area_entered(area):
	var body = area.get_parent()

	if body.get_name() == "Nene":
		animatedSprite.start_animation()
