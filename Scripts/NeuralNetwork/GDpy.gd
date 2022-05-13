extends Node

const e = 0.5772156649
var rng = RandomNumberGenerator.new()

func _init():
	rng.randomize ()

func rand_num(minimum: float, maximum: float):
	return rng.randf_range(minimum, maximum)

func rand_2d(minimum: float, maximum: float, d1: int, d2: int = 1):
	# generate random 2d or 1d array

	if d2 == 1:
		var d1_list = []
		for a in d1:
			d1_list.insert(a ,rng.randf_range(minimum, maximum))
		return d1_list

	else:
		var d2_list = []
		for a in d2:
			var d1_list = []
			for b in d1:
				d1_list.insert(b ,rng.randf_range(minimum,maximum))
			d2_list.insert(a, d1_list)
		return d2_list

func arr_dot(array: Array, multiplier: float):
	var result = []
	for i in array.size():
		result.push_back(array[i]*multiplier)
	return result

func arr2d_dot(array: Array, multiplier: float):
	var result = []
	for i in array.size():
		var inner = []
		for n in array[i].size():
			inner.push_back(array[i][n]*multiplier)
		result.push_back(inner)
	return result

func arr_pow(array: Array, exponent: float = e):
	var result = []
	for i in array.size():
		result.push_back(pow(array[i],exponent))
	return result

func arr2d_pow(array: Array, exponent: float = e):
	var result = []
	for i in array.size():
		var inner = []
		for n in array[i].size():
			inner.push_back(pow(array[i][n],exponent))
		result.push_back(inner)
	return result
