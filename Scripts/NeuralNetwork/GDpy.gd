extends Node

const e = 2.71828
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
	
func arr_sum(array: Array):
	var result = 0
	for i in array.size():
		result += array[i]
	return result

func arr2d_sum(array: Array, keep_dims: bool = false):
	if not keep_dims:
		var result = 0
		for i in array.size():
			for n in array[i].size():
				result += array[i][n]
		return result
	else:
		var result = []
		for i in array.size():
			var dim_sum = 0
			for n in array[i].size():
				dim_sum += array[i][n]
			result.push_back(dim_sum)
		return result

func arr_div(array: Array, divisor: float):
	var result = []
	for i in array.size():
		result.push_back(array[i]/divisor)
	return result

func arr2d_div(array: Array, divisor: float):
	var result = []
	for i in array.size():
		var dim_quotient = []
		for n in array[i].size():
			dim_quotient.push_back(array[i][n]/divisor)
		result.push_back(result)
	return result

func arr_add(array1: Array, array2: Array):
	# should be the same length
	var result = []
	for i in array1.size():
		result.push_back(array1[i] + array2[i])
	return result

func arr2d_add(array1: Array, array2: Array):
	# shape should be consistent
	var result = []
	for i in array1.size():
		var batch = []
		for n in array1[i].size():
			batch.push_back(array1[i][n] + array2[i][n])
		result.push_back(batch)
	return result
