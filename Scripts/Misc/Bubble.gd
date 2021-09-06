extends KinematicBody2D

const type = "BUBBLE"
const float_speed = 100
var underwater = true
var state = FLOAT
var velocity = Vector2(0,0)

onready var animationPlayer = get_node("AnimationPlayer")

enum{
	FLOAT,
	BURST
}

func _ready():
	set_size()

func _physics_process(delta):
	special_checkers()
	match state:
		FLOAT:
			floating()
		BURST:
			burst()

#==============state functions============

func floating():
	animationPlayer.play("Float")
	self.velocity.y = -float_speed
	self.velocity.y = self.velocity.y
	velocity = move_and_slide(velocity, Vector2.DOWN)

func burst():
	animationPlayer.play("Burst")
	
#==============special functions============

func special_checkers():
	if not underwater:
		state = BURST
		
		
func set_size():
	var size = rand_range(1.5 ,3)
	self.scale.x = size
	self.scale.y =  size

#=============sensor/event functions=========

func burst_finished():
	self.queue_free()

