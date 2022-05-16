extends CanvasLayer

onready var health = get_node("Health/AnimationPlayer")
onready var points = get_node("Points")# Replace with function body.
onready var epoch = get_node("Epoch")
onready var epoch_time = get_node("EpochTime")
onready var generation = get_node("Generation")

func _physics_process(_delta) -> void:
	points.text = str(PlayerStats.points).pad_zeros(4)
	epoch.text = "Epoch: " + str(Global.data.epoch)
	generation.text = "Generation: " + str(Global.data.generation)
	epoch_time.text = "Epoch Time: " + str(Global.epoch_timer) + "s"

func animate_health() -> void:
	health.play("Blink")
