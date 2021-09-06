extends StaticBody2D

export var damage:int = 10

const collisions = ["PLAYER", "ENEMY", "BLOCK"]
onready var particle = get_node("Particles2D")
onready var animationPlayer = get_node("AnimatedSprite/AnimationPlayer")

func _ready():
	particle.emitting = true
	animationPlayer.play("Explode")

func animation_finished():
	self.queue_free()

#===============sensor/event functions========================

func _on_AOE_body_entered(body):
	if "type" in body:
		if collisions.has(body.type):
			if body.has_method("take_damage"):
				body.take_damage(damage)
