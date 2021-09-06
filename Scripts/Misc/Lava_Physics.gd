extends Area2D


const damage = 3
const type = "WATER"
const lava_splash = preload("res://Prefabs/Misc/Lava_Splash.tscn")
const burn = preload("res://Prefabs/Misc/Lava_Burn.tscn")
var swimming = []

onready var timer = get_node("Timer")

func _physics_process(delta):
	check_swimming()

#===============sensor functions======================
func _on_Lava_Physics_body_entered(body):
	if "type" in body:
		match body.type:
			"PLAYER":
				spawn_splash(body.get_position())
				mob_physics_entered(body)	
			"ENEMY":
				spawn_splash(body.get_position())
				mob_physics_entered(body)


func _on_Lava_Physics_body_exited(body):
	if "type" in body:
		match body.type:
			"PLAYER":
				mob_physics_exited(body)
			"ENEMY":
				mob_physics_exited(body)

func _on_Lava_Physics_area_entered(area):
	var body = area.get_parent()
	
	if area.get_name() == "Head":
		body.underwater = true
		
	if "type" in body:
		if not body.underwater:
				spawn_splash(body.get_position())


func _on_Lava_Physics_area_exited(area):
	var body = area.get_parent()
	
	if area.get_name() == "Head":
		body.underwater = false
		
	if area.get_name() == "Surface_Tension":
		body.underwater = false

#===========================special functions================

func spawn_splash(position):
	var splash = lava_splash.instance()
	splash.position = position
	get_tree().get_current_scene().get_node("World").add_child(splash)

	
func mob_physics_entered(mob):
	mob.on_water = true
	mob.on_lava = true
	mob.velocity = Vector2(0,0)
	swimming.push_back(mob)
	apply_burn(mob)
	
func mob_physics_exited(mob):
	mob.on_water = false
	mob.on_lava = false
	swimming.remove(swimming.rfind(mob))

func apply_burn(mob):
	if mob.get_node_or_null("Lava_Burn") == null:
		var fire = burn.instance()
		fire.damage = self.damage
		mob.add_child(fire)

func check_swimming():
	for mob in swimming:
		if mob.has_method("take_damage"):
			apply_burn(mob)

