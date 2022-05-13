extends Node2D

const LayerDense = preload("res://Scripts/NeuralNetwork/LayerDense.gd")
const ActivationReLu = preload("res://Scripts/NeuralNetwork/ActivationReLU.gd")
const ActivationSoftmax = preload("res://Scripts/NeuralNetwork/ActivationSoftmax.gd")
const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

onready var gdpy = GDpy.new()

func _ready():
	var layer1 = LayerDense.new(3,5)
	var activation1 = ActivationReLu.new()
	var layer2 = LayerDense.new(5,5)
	var activation2 = ActivationSoftmax.new()
	var input = [1,2,3]
	var input2d = [[1,2,3],[3,2,1]]
	layer1.forward(input)
	activation1.forward(layer1.output)
	print(activation1.output)
	layer2.forward(activation1.output)
	print(layer2.output)
	activation2.forward(layer2.output)

	print(gdpy.arr2d_pow(input2d))


