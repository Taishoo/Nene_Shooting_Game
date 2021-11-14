extends CanvasLayer

onready var health = get_node("Health/AnimationPlayer")
onready var points = get_node("Points")# Replace with function body.

func _physics_process(_delta) -> void:
	points.text = str(PlayerStats.points).pad_zeros(4)

func animate_health() -> void:
	health.play("Blink")
