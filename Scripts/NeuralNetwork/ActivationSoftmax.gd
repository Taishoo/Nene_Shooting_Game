extends Node

const GDpy = preload("res://Scripts/NeuralNetwork/GDpy.gd")

var gdpy: GDpy
var batch: bool = false
var output = []

func _init(isbatch: bool = false) -> void:
	gdpy = GDpy.new()
	self.batch = isbatch

func forward(inputs: Array) -> void: # softmax =  u / (Σ ui) ∵ u = x^e
	if not self.batch:
		# single input with multiple layers of neurons
		var exp_values = gdpy.arr_pow(inputs) #[]
		self.output = gdpy.arr_div(exp_values, gdpy.arr_sum(exp_values))
	else:
		# batches of input with multiple layers of neurons
		var exp_values = gdpy.arr2d_pow(inputs) #[][]
		var exp_sum = gdpy.arr2d_sum(exp_values,true)
		self.output = []
		for i in exp_sum.size():
			var batch_quotient = []
			for n in exp_values[i].size():
				batch_quotient.push_back(exp_values[i][n] / exp_sum[i])
			self.output.push_back(batch_quotient)
