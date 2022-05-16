extends StaticBody2D

var rng = RandomNumberGenerator.new()

export var variable:String
const value = 1
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

func _init() -> void:
	rng.randomize ()

func _ready() -> void:
	spawn()
	animationPlayer.play("Animate")

func spawn() -> void:
	self.position = Vector2(522.898, -982.88)

func hide() -> void:
	self.position = Vector2(99999.898, -99999.88)

func _on_Area2D_body_entered(body) -> void:
	if "type" in body:
		if body.type == "PLAYER":
			PlayerStats.points += value
			Global.points_on_hold += (value - (Global.timer * 0.01))
			Global.timer = 0
			hide()
