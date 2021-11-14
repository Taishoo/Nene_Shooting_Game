extends KinematicBody2D

var on_water:bool = false
var underwater:bool = false
var on_lava:bool = false
var on_fire:bool = false

var velocity:Vector2 = Vector2(0,0)
var mouse_position:Vector2 = Vector2(0,0)
var just_jumped:bool = false

const collision_ignore = ["PLAYER", "ENEMY"]

func calculate_chase_vector(current_position,target_position, walk_speed) -> float:
	var margin = 10
	if current_position.x > target_position.x + margin:
		return -walk_speed
	elif current_position.x < target_position.x - margin:
		return walk_speed
	else:
		return 0.0

func calculate_vertical_vector(current_position,target_position, walk_speed) -> float:
	var margin = 0
	if current_position.y > target_position.y + margin:
		return -walk_speed
	elif current_position.y < target_position.y - margin:
		return walk_speed
	else:
		return 0.0
