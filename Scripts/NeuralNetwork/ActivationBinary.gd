extends Node

const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

var gdpy: GDpy
var batch: bool = false
var output = []

func _init(isbatch: bool = false) -> void:
	gdpy = GDpy.new()
	self.batch = isbatch

func forward(inputs: Array) -> void: # Binary = (x > 0 → 1) ∧ (x < 0 → 0)
	if not batch:
		# single input with multiple layers of neurons
		self.output = []
		for i in inputs.size():
			self.output.push_back(1 if inputs[i] > 0 else 0)
	
	else:
		# batches of input with multiple layers of neurons
		self.output = []
		for i in inputs.size():
			var batch_output = []
			for n in inputs[i].size():
				batch_output.push_back(1 if inputs[i][n] > 0 else 0)
			self.output.push_back(batch_output)