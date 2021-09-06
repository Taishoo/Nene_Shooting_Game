extends Particles2D


func _ready():
	self.emitting = true
	

func _on_Timer_timeout():
	self.queue_free()
