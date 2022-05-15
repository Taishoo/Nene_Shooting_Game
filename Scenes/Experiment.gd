extends Node2D

const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")
onready var gdpy = GDpy.new()

onready var player = get_node("World/Nene")
onready var coin = get_node("World/Coin")
onready var model = get_node("NeuralNetwork")


func _ready():
	pass # Replace with function body.

func _physics_process(_delta) -> void:

	if Input.is_action_just_pressed("next_epoch"):
		calculate_loss()

	if Input.is_action_just_pressed("display_values"):
		print_model()

	if Input.is_action_just_pressed("increment_timer"):
		Global.epoch_timer += 1

	if Input.is_action_just_pressed("decrement_timer"):
		var x = Global.epoch_timer - 1
		Global.epoch_timer = 3 if x < 3 else x

func calculate_loss() -> void:
	var t = Global.timer if Global.timer != 0 else 0.001
	var s = Global.points_on_hold
	var u_best = Global.u_best
	var u_next = ( s - (t * 0.01) ) * 0.1

	print(str(u_next) + " = " + str(u_best))

	if u_next > u_best:
		Global.u_best = u_next
		Global.generation += 1
		set_best_generation()
	else:
		retain_current_generation()

	reset_and_increment()

func reset_and_increment() -> void:
	# reset
	Global.timer = 0
	Global.points_on_hold = 0
	PlayerStats.points = 0
	player.position = Vector2(550.828, 322.242)
	coin.change_location()

	# increment
	Global.epoch += 1
	#increment set weights and biases
	model.layer1.weights = gdpy.arr2d_add(model.layer1.weights, gdpy.arr2d_dot(gdpy.rand_2d(-1, 1, 18,7), 0.5))
	model.layer1.bias = gdpy.arr_add(model.layer1.bias, gdpy.arr_dot(gdpy.rand_2d(-1, 1, 7,1), 0.5))

	model.layer2.weights = gdpy.arr2d_add(model.layer2.weights, gdpy.arr2d_dot(gdpy.rand_2d(-1, 1, 7,7), 0.5))
	model.layer2.bias = gdpy.arr_add(model.layer2.bias, gdpy.arr_dot(gdpy.rand_2d(-1, 1, 7,1), 0.5))

	model.layer3.weights = gdpy.arr2d_add(model.layer3.weights, gdpy.arr2d_dot(gdpy.rand_2d(-1, 1, 7,3), 0.5))
	model.layer3.bias = gdpy.arr_add(model.layer3.bias, gdpy.arr_dot(gdpy.rand_2d(-1, 1, 3,1), 0.5))



func set_best_generation():
	print("superior generation has found")
	Global.best_layer1_weights = model.layer1.weights
	Global.best_layer1_bias = model.layer1.bias
	Global.best_layer2_weights = model.layer2.weights
	Global.best_layer2_bias = model.layer2.bias
	Global.best_layer3_weights = model.layer3.weights
	Global.best_layer3_bias = model.layer3.bias

func retain_current_generation():
	print("retaining current best generation")
	model.layer1.weights = Global.best_layer1_weights
	model.layer1.bias = Global.best_layer1_bias
	model.layer2.weights =	Global.best_layer2_weights
	model.layer2.bias = Global.best_layer2_bias
	model.layer3.weights = Global.best_layer3_weights
	model.layer3.bias = Global.best_layer3_bias

func print_model() -> void:
	print("========Layer1==========")
	print(model.layer1.weights)
	print(model.layer1.bias)
	print("========Layer2==========")
	print(model.layer2.weights)
	print(model.layer2.bias)
	print("========Layer3==========")
	print(model.layer3.weights)
	print(model.layer3.bias)

func _on_Timer_timeout()-> void:
	Global.timer += 1
	get_node("Timer").start()


func _on_EpochTimer_timeout():
	calculate_loss()
	get_node("EpochTimer").start(Global.epoch_timer)
