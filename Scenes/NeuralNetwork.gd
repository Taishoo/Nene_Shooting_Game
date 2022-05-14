extends Node2D

const LayerDense = preload("res://Scripts/NeuralNetwork/LayerDense.gd")
const ActivationReLu = preload("res://Scripts/NeuralNetwork/ActivationReLU.gd")
const ActivationBinary = preload("res://Scripts/NeuralNetwork/ActivationBinary.gd")
const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

onready var gdpy = GDpy.new()

onready var player = get_tree().get_current_scene().get_node("World/Nene")
onready var player_sensor = player.get_node("Sensors")

# neural network setup
onready var layer1 = LayerDense.new(18,7)
onready var activation1 = ActivationReLu.new()
onready var layer2 = LayerDense.new(7,7)
onready var activation2 = ActivationReLu.new()
onready var layer_output = LayerDense.new(7,3)
onready var activation_output = ActivationBinary.new()

func _physics_process(delta) -> void:
	var input = gdpy.arr_dot(player_sensor.sensor_output, 1)
	front_propagate(input, delta)


func front_propagate(input, delta) -> void:
	layer1.forward(input)
	activation1.forward(layer1.output)
	layer2.forward(activation1.output)
	activation2.forward(layer2.output)
	layer_output.forward(activation2.output)
	activation_output.forward(layer_output.output)
	player.neural_control(activation_output.output, delta)




