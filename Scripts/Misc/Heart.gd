extends TextureRect


export var min_val:int = 19
export var max_val:int = 20

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if PlayerStats.health >= max_val:
		self.texture = load("res://Sprites/Objects/Heart/Heart.png")
	elif PlayerStats.health == min_val:
		self.texture = load("res://Sprites/Objects/Heart/Heart_Half.png")
	else:
		self.texture = load("res://Sprites/Objects/Heart/Heart_Empty.png")
