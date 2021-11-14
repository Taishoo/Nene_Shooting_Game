extends Node2D

const type:String = "BURN"

export var damage: int = 1

onready var parent = get_parent()
onready var dps = get_node("DPS")
onready var timer = get_node("Timer")
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

func _ready() -> void:
	animationPlayer.play("Burn")
	parent.on_fire = true;

func _on_DPS_timeout() -> void:
	if parent.has_method("take_damage"):
		parent.take_damage(damage)

func _on_Timer_timeout() -> void:
	self.queue_free()

func _on_Lava_Burn_tree_exiting() -> void:
	parent.on_fire = false
