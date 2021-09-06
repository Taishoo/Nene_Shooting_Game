extends CanvasLayer

onready var health = get_node("Health/AnimationPlayer")
onready var points = get_node("Points")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	points.text = str(PlayerStats.points).pad_zeros(4)


func animate_health():
	health.play("Blink")
