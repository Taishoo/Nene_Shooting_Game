extends Node2D


export var frequency:int = 1
export var area_size:Vector2 = Vector2(10,10)
export var burst:bool = false
export var emitting:bool = true

const particle = preload("res://Prefabs/Misc/Bubble.tscn")

onready var timer = get_node("Timer")

func _ready():
	if emitting and burst:
		burst()


func _physics_process(delta):
	if emitting and not burst:
		emit()
	
#==============special functions============

func burst():
	for spawn in frequency:
		yield(get_tree().create_timer(0.001), "timeout")
		spawn_bubble()		
	self.queue_free()
	
func emit():
	if timer.is_stopped():
		spawn_bubble()
		timer.start(1.0 / frequency)
		
	
func spawn_bubble():
		var bubble = particle.instance()
		bubble.position = self.get_global_position()
		bubble.position.x = bubble.position.x + rand_range(-area_size.x, area_size.x)
		bubble.position.y = bubble.position.y + rand_range(-area_size.y, area_size.y)
		get_tree().get_current_scene().get_node("World").add_child(bubble)
	
#===============sensor/event functions=======


func _on_Timer_timeout():
	timer.stop()
