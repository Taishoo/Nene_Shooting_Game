extends Node2D

const limit = 500

onready var player = get_parent()
onready var point = get_parent().get_node("Contact")
onready var coin = get_tree().get_current_scene().get_node_or_null("World/Coin")

onready var ray1p = player.get_node("Ray1p")
onready var ray2p = player.get_node("Ray2p")
onready var ray3p = player.get_node("Ray3p")
onready var ray4p = player.get_node("Ray4p")
onready var ray5p = player.get_node("Ray5p")
onready var ray6p = player.get_node("Ray6p")
onready var ray7p = player.get_node("Ray7p")
onready var ray8p = player.get_node("Ray8p")
onready var ray9p = player.get_node("Ray9p")
onready var ray10p = player.get_node("Ray10p")
onready var ray11p = player.get_node("Ray11p")
onready var ray12p = player.get_node("Ray12p")
onready var ray13p = player.get_node("Ray13p")
onready var ray14p = player.get_node("Ray14p")
onready var ray15p = player.get_node("Ray15p")
onready var ray16p = player.get_node("Ray16p")

onready var ray1w = player.get_node("Ray1w")
onready var ray2w = player.get_node("Ray2w")
onready var ray3w = player.get_node("Ray3w")
onready var ray4w = player.get_node("Ray4w")
onready var ray5w = player.get_node("Ray5w")
onready var ray6w = player.get_node("Ray6w")
onready var ray7w = player.get_node("Ray7w")
onready var ray8w = player.get_node("Ray8w")
onready var ray9w = player.get_node("Ray9w")
onready var ray10w = player.get_node("Ray10w")
onready var ray11w = player.get_node("Ray11w")
onready var ray12w = player.get_node("Ray12w")
onready var ray13w = player.get_node("Ray13w")
onready var ray14w = player.get_node("Ray14w")
onready var ray15w = player.get_node("Ray15w")
onready var ray16w = player.get_node("Ray16w")

export var sensor_output = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

func _physics_process(_delta) -> void:
	# 16 sensor for platform
	sensor_output[0] = clip_to(ray1p.global_position.distance_to(ray1p.get_collision_point()), limit)
	sensor_output[1] = clip_to(ray2p.global_position.distance_to(ray2p.get_collision_point()), limit)
	sensor_output[2]= clip_to(ray3p.global_position.distance_to(ray3p.get_collision_point()), limit)
	sensor_output[3] = clip_to(ray4p.global_position.distance_to(ray4p.get_collision_point()), limit)
	sensor_output[4] = clip_to(ray5p.global_position.distance_to(ray5p.get_collision_point()), limit)
	sensor_output[5]= clip_to(ray6p.global_position.distance_to(ray6p.get_collision_point()), limit)
	sensor_output[6] = clip_to(ray7p.global_position.distance_to(ray7p.get_collision_point()), limit)
	sensor_output[7] = clip_to(ray8p.global_position.distance_to(ray8p.get_collision_point()), limit)
	sensor_output[8] = clip_to(ray9p.global_position.distance_to(ray9p.get_collision_point()), limit)
	sensor_output[9] = clip_to(ray10p.global_position.distance_to(ray10p.get_collision_point()), limit)
	sensor_output[10] = clip_to(ray11p.global_position.distance_to(ray11p.get_collision_point()), limit)
	sensor_output[11] = clip_to(ray12p.global_position.distance_to(ray12p.get_collision_point()), limit)
	sensor_output[12] = clip_to(ray13p.global_position.distance_to(ray13p.get_collision_point()), limit)
	sensor_output[13] = clip_to(ray14p.global_position.distance_to(ray14p.get_collision_point()), limit)
	sensor_output[14] = clip_to(ray15p.global_position.distance_to(ray15p.get_collision_point()), limit)
	sensor_output[15] = clip_to(ray16p.global_position.distance_to(ray16p.get_collision_point()), limit)

	# 16 sensor for walls
	sensor_output[16] = clip_to(ray1w.global_position.distance_to(ray1w.get_collision_point()), limit)
	sensor_output[17] = clip_to(ray2w.global_position.distance_to(ray2w.get_collision_point()), limit)
	sensor_output[18]= clip_to(ray3w.global_position.distance_to(ray3w.get_collision_point()), limit)
	sensor_output[19] = clip_to(ray4w.global_position.distance_to(ray4w.get_collision_point()), limit)
	sensor_output[20] = clip_to(ray5w.global_position.distance_to(ray5w.get_collision_point()), limit)
	sensor_output[21]= clip_to(ray6w.global_position.distance_to(ray6w.get_collision_point()), limit)
	sensor_output[22] = clip_to(ray7w.global_position.distance_to(ray7w.get_collision_point()), limit)
	sensor_output[23] = clip_to(ray8w.global_position.distance_to(ray8w.get_collision_point()), limit)
	sensor_output[24] = clip_to(ray9w.global_position.distance_to(ray9w.get_collision_point()), limit)
	sensor_output[25] = clip_to(ray10w.global_position.distance_to(ray10w.get_collision_point()), limit)
	sensor_output[26] = clip_to(ray11w.global_position.distance_to(ray11w.get_collision_point()), limit)
	sensor_output[27] = clip_to(ray12w.global_position.distance_to(ray12w.get_collision_point()), limit)
	sensor_output[28] = clip_to(ray13w.global_position.distance_to(ray13w.get_collision_point()), limit)
	sensor_output[29] = clip_to(ray14w.global_position.distance_to(ray14w.get_collision_point()), limit)
	sensor_output[30] = clip_to(ray15w.global_position.distance_to(ray15w.get_collision_point()), limit)
	sensor_output[31] = clip_to(ray16w.global_position.distance_to(ray16w.get_collision_point()), limit)

	# 2 sensor for coin location
	sensor_output[32] = coin.get_position().x
	sensor_output[33] = coin.get_position().y

	# 1 sensor for on floor
	sensor_output[33] = 1 if player.is_on_floor() else -1

func clip_to(value: float, limit: float) -> float:
	var result = 0
	if limit != null:
		result = limit if value >= limit else value
	else:
		result = value
	return result
