extends Node2D

const LayerDense = preload("res://Scripts/NeuralNetwork/LayerDense.gd")
const ActivationReLu = preload("res://Scripts/NeuralNetwork/ActivationReLU.gd")
const ActivationBinary = preload("res://Scripts/NeuralNetwork/ActivationBinary.gd")
const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

onready var gdpy = GDpy.new()

onready var player = get_tree().get_current_scene().get_node("World/Nene")

# neural network setup
var input = [1,2,3,2,3,1,5,3]
onready var layer1 = LayerDense.new(8,7)
onready var activation1 = ActivationReLu.new()
onready var layer2 = LayerDense.new(7,7)
onready var activation2 = ActivationReLu.new()
onready var layer_output = LayerDense.new(7,3)
onready var activation_output = ActivationBinary.new()

func _ready() -> void:
	front_propagate()

func front_propagate() -> void:
	layer1.forward(input)
	activation1.forward(layer1.output)
	layer2.forward(activation1.output)
	activation2.forward(layer2.output)
	layer_output.forward(activation2.output)
	activation_output.forward(layer_output.output)
	print(activation_output.output)


