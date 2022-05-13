extends Node

var batch: bool = false
var output = []

func _init(isbatch: bool = false) -> void:
		self.batch = isbatch

func forward(inputs: Array) -> void:
	pass
