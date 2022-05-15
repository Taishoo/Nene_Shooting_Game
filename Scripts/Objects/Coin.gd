extends StaticBody2D

var rng = RandomNumberGenerator.new()

export var variable:String
const value = 1
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

export var spawn_locations = [Vector2(1132.05,134.606), Vector2(517.561, -55.038),
Vector2(162.641, 142.022), Vector2(-266.441, 233.136), Vector2(1429.759, 178.044),
 Vector2(739.759, 289.044), Vector2(1437.759, 425.044), Vector2(-281.675, 426.826)]

onready var index = rng.randi_range(0,spawn_locations.size() - 1)

func _init() -> void:
	rng.randomize ()

func _ready() -> void:
	self.position = spawn_locations[index]
	animationPlayer.play("Animate")

func change_location() -> void:
	index = rng.randi_range(0,spawn_locations.size() -1)
	self.position = spawn_locations[index]

func _on_Area2D_body_entered(body) -> void:
	if "type" in body:
		if body.type == "PLAYER":
			PlayerStats.points += value
			Global.points_on_hold += (value - (Global.timer * 0.01))
			Global.timer = 0
			index = rng.randi_range(0,spawn_locations.size() - 1)
			self.position = spawn_locations[index]
