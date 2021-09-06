extends Control

const damage = 3

onready var bubbles = get_node("Bubbles")
onready var weapons = get_parent().get_node_or_null("Weapon")
onready var player = get_tree().get_current_scene().get_node_or_null("World/Nene")
onready var timer = get_node("Timer")


func _physics_process(_delta):
	check_underwater()

	if player.underwater:
		if timer.is_stopped():
			timer.start(1)
	else:
		timer.stop()
		PlayerStats.air = PlayerStats.max_air

func check_underwater():
	if player != null:
		bubbles.visible = true if player.underwater and not player.on_lava else false
		weapons.rect_position = Vector2(0,22) if player.underwater and not player.on_lava else Vector2(0,12)

func _on_Timer_timeout():
	if not PlayerStats.air <= 0: 
		PlayerStats.air -= 1
	else:
		player.take_damage(damage)
