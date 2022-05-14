extends Node

var batch: bool = false
var output = []

func _init(isbatch: bool = false) -> void:
		self.batch = isbatch

func forward(inputs: Array) -> void: # ReLU = (x > 0 → x) ∧ (x < 0 → 0)
	if not self.batch:
		# single input with multiple layers of neurons
		self.output = []
		for i in inputs.size():
			self.output.push_back(inputs[i] if inputs[i] > 0 else 0)
	else:
		# batches of input with multiple layers of neurons
		self.output = []
		for i in inputs.size():
			var batch_output = []
			for n in inputs[i].size():
				batch_output.push_back(inputs[i][n] if inputs[i][n] > 0 else 0)
			self.output.push_back(batch_output)

