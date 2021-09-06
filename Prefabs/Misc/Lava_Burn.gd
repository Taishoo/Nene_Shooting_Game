extends Node2D

export var damage: int = 1

onready var parent = get_parent()
onready var dps = get_node("DPS")
onready var timer = get_node("Timer")
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

func _ready():
	animationPlayer.play("Burn")


func _on_DPS_timeout():
	if parent.has_method("take_damage"):
		parent.take_damage(damage)

func _on_Timer_timeout():
	self.queue_free()
