extends KinematicBody2D

const collision_ignore = ["PLAYER", "ENEMY"]

func calculate_chase_vector(current_position,target_position, walk_speed):
	var margin = 10
	if current_position.x > target_position.x + margin:
		return -walk_speed
	elif current_position.x < target_position.x - margin:
		return walk_speed
	else:
		return 0

func calculate_vertical_vector(current_position,target_position, walk_speed):
	var margin = 0
	if current_position.y > target_position.y + margin:
		return -walk_speed
	elif current_position.y < target_position.y - margin:
		return walk_speed
	else:
		return 0
