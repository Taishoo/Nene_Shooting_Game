extends Node2D

const limit = 300

onready var player = get_parent()
onready var point = get_parent().get_node("Contact")
onready var coin = get_tree().get_current_scene().get_node_or_null("World/Coin")

onready var ray1 = player.get_node("Ray1")
onready var ray2 = player.get_node("Ray2")
onready var ray3 = player.get_node("Ray3")
onready var ray4 = player.get_node("Ray4")
onready var ray5 = player.get_node("Ray5")
onready var ray6 = player.get_node("Ray6")
onready var ray7 = player.get_node("Ray7")
onready var ray8 = player.get_node("Ray8")
onready var ray9 = player.get_node("Ray9")
onready var ray10 = player.get_node("Ray10")
onready var ray11 = player.get_node("Ray11")
onready var ray12 = player.get_node("Ray12")
onready var ray13 = player.get_node("Ray13")
onready var ray14 = player.get_node("Ray14")
onready var ray15 = player.get_node("Ray15")
onready var ray16 = player.get_node("Ray16")

export var sensor_output = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

func _physics_process(_delta) -> void:
	sensor_output[0] = clip_to(ray1.global_position.distance_to(ray1.get_collision_point()), limit)
	sensor_output[1] = clip_to(ray2.global_position.distance_to(ray2.get_collision_point()), limit)
	sensor_output[2]= clip_to(ray3.global_position.distance_to(ray3.get_collision_point()), limit)
	sensor_output[3] = clip_to(ray4.global_position.distance_to(ray4.get_collision_point()), limit)
	sensor_output[4] = clip_to(ray5.global_position.distance_to(ray5.get_collision_point()), limit)
	sensor_output[5]= clip_to(ray6.global_position.distance_to(ray6.get_collision_point()), limit)
	sensor_output[6] = clip_to(ray7.global_position.distance_to(ray7.get_collision_point()), limit)
	sensor_output[7] = clip_to(ray8.global_position.distance_to(ray8.get_collision_point()), limit)
	sensor_output[8] = clip_to(ray9.global_position.distance_to(ray9.get_collision_point()), limit)
	sensor_output[9] = clip_to(ray10.global_position.distance_to(ray10.get_collision_point()), limit)
	sensor_output[10] = clip_to(ray11.global_position.distance_to(ray11.get_collision_point()), limit)
	sensor_output[11] = clip_to(ray12.global_position.distance_to(ray12.get_collision_point()), limit)
	sensor_output[12] = clip_to(ray13.global_position.distance_to(ray13.get_collision_point()), limit)
	sensor_output[13] = clip_to(ray14.global_position.distance_to(ray14.get_collision_point()), limit)
	sensor_output[14] = clip_to(ray15.global_position.distance_to(ray15.get_collision_point()), limit)
	sensor_output[15] = clip_to(ray16.global_position.distance_to(ray16.get_collision_point()), limit)
	sensor_output[16] = coin.get_position().x
	sensor_output[17] = coin.get_position().y


func clip_to(value: float, limit: float) -> float:
	var result = 0
	if limit != null:
		result = limit if value >= limit else value
	else:
		result = value
	return result
