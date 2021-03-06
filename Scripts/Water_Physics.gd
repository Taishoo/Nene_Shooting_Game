extends Area2D


const type = "WATER"
const water_splash = preload("res://Prefabs/Misc/Water_Splash.tscn")

func _on_Water_Physics_body_entered(body) -> void:
	if "type" in body:
		remove_fire(body)
		match body.type:
			"PLAYER":
				spawn_splash(body.get_position())
				mob_physics_entered(body)	
			"ENEMY":
				spawn_splash(body.get_position())
				mob_physics_entered(body)

func _on_Water_Physics_body_exited(body) -> void:
	if "type" in body:
		match body.type:
			"PLAYER":
				mob_physics_exited(body)
			"ENEMY":
				mob_physics_exited(body)
				

func _on_Water_Physics_area_entered(area: Area2D):
	var body = area.get_parent()
	
	if area.get_name() == "Head":
		body.underwater = true
		
	if "type" in body:
		if not body.underwater:
				spawn_splash(body.get_position())

func _on_Water_Physics_area_exited(area):
	var body = area.get_parent()
	
	if area.get_name() == "Head":
		body.underwater = false
		
	if area.get_name() == "Surface_Tension":
		body.underwater = false
	
#===================process functions=======================
	
func mob_physics_entered(mob) -> void:
	mob.on_water = true
	mob.velocity = Vector2(0,0)
	
func mob_physics_exited(mob) -> void:
	mob.on_water = false

func remove_fire(mob) -> void:
	if mob.on_fire:
		mob.get_node_or_null("Lava_Burn").queue_free()
	

#=========================special functions==============

func spawn_splash(position: Vector2) -> void:
	var splash = water_splash.instance()
	splash.position = position
	get_tree().get_current_scene().get_node("World").add_child(splash)
