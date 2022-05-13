extends Node

const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

# layer configurations
var gdpy: GDpy
var batch: bool = false
var bias_range = Vector2(-5, 5)
var num_range = Vector2(-1, 1)

# NN variables
var weights
var bias
var output 

func _init(n_inputs: int, n_neurons: int = 1, isbatch: bool = false) -> void:
	gdpy = GDpy.new()
	self.batch = isbatch
	self.weights = gdpy.rand_2d(num_range.x, num_range.y, n_inputs, n_neurons) 
	self.bias = gdpy.rand_2d(bias_range.x, bias_range.y, n_neurons, 1)

func forward(inputs: Array) -> void:
	# f(x,w) = b + (Σ xi*wi)
	if not self.batch:
		# single input with multiple layers of neurons
		self.output = []
		for i in bias.size():
			var neural_output = 0
			for n in weights[i].size():
				neural_output = neural_output + (weights[i][n] * inputs[n])
			self.output.push_back(neural_output + bias[i])
	else:
		# batches of input with multiple layers of neurons
		self.output = []
		for x in inputs.size():
			var batch_output = []
			for i in bias.size():
				var neural_output = 0
				for n in weights[i].size():
					neural_output = neural_output + (weights[i][n] * inputs[x][n])
				batch_output.push_back(neural_output + bias[i])
			self.output.push_back(batch_output)
