extends Node2D

const LayerDense = preload("res://Scripts/NeuralNetwork/LayerDense.gd")
const ActivationReLu = preload("res://Scripts/NeuralNetwork/ActivationReLU.gd")
const ActivationBinary = preload("res://Scripts/NeuralNetwork/ActivationBinary.gd")
const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

onready var gdpy = GDpy.new()

onready var player = get_tree().get_current_scene().get_node("World/Nene")
onready var player_sensor = player.get_node("Sensors")

# neural network setup
onready var layer1 = LayerDense.new(35,12)
onready var activation1 = ActivationReLu.new()
onready var layer2 = LayerDense.new(12,12)
onready var activation2 = ActivationReLu.new()
onready var layer3 = LayerDense.new(12,3)
onready var activation3 = ActivationBinary.new()

func _ready():
	Engine.time_scale = Global.speed
	set_initial_best_generation()

func _physics_process(delta) -> void:
	var input = gdpy.arr_dot(player_sensor.sensor_output, 1)
	front_propagate(input, delta)

func front_propagate(input, delta) -> void:
	layer1.forward(input)
	activation1.forward(layer1.output)
	layer2.forward(activation1.output)
	activation2.forward(layer2.output)
	layer3.forward(activation2.output)
	activation3.forward(layer3.output)
	player.neural_control(activation3.output, delta)

func set_initial_best_generation():
	print("initial gen set")
	Global.data.model.layer1_weights = layer1.weights
	Global.data.model.layer1_bias = layer1.bias
	Global.data.model.layer2_weights = layer2.weights
	Global.data.model.layer2_bias = layer2.bias
	Global.data.model.layer3_weights = layer3.weights
	Global.data.model.layer3_bias = layer3.bias




