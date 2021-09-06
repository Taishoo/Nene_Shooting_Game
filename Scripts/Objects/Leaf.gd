extends StaticBody2D

const type = "BLOCK"

var with_wood:bool
var woods = []
onready var timer = get_node("Timer")
onready var particles = get_node("Destroy")

#+==============sensor/event function===========

func _on_WoodDetector_body_exited(body):
	if "sub_type" in body:
		woods.remove(woods.rfind(body))
		if woods.size() == 0:
			timer.start(rand_range(3,10))

func _on_WoodDetector_body_entered(body):
	if "sub_type" in body:
		if body.sub_type == "WOOD":
			woods.push_back(body)
			

func _on_Timer_timeout():
	particles.visible = true
	particles.emitting = true
	get_node("CollisionShape2D").disabled = true
	get_node("Sprite").visible = false
	
	yield(get_tree().create_timer(0.3), "timeout")
	self.queue_free()
