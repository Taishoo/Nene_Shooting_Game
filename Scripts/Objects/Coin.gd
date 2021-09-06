extends StaticBody2D

export var variable:String
const value = 1
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

func _ready():
	animationPlayer.play("Animate")


func _on_Area2D_body_entered(body):
	if "type" in body:
		if body.type == "PLAYER":
			PlayerStats.points += value
			Global.points_on_hold += value
			self.queue_free()
