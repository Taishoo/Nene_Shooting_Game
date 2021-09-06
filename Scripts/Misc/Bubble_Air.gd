extends TextureRect

export var index = 10

onready var animationPlayer = get_node("AnimationPlayer")

var popped = false

func _ready():
	pass


func _physics_process(_delta):
	if PlayerStats.air < index and not popped:
		# popped = true
		# self.texture = load("res://Sprites/Objects/Bubble/Bubble_Burst.png")
		# yield(get_tree().create_timer(0.15), "timeout")
		self.visible = false
	else:
		# popped = false
		# self.texture = load("res://Sprites/Objects/Bubble/Bubble_Float.png")
		# animationPlayer.play("Idle")
		self.visible = true

