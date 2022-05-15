extends Node

const GRAVITY:float = 30.00
var epoch_timer: int = 7

var CAN_MOVE:bool = true
var CAN_PAUSE:bool = true
var CAN_JUMP:bool = true


var u_best: float = 0
var points_on_hold:float = 0
var timer: int = 0
var epoch: int = 0
var generation: int = 0

# model data
var best_layer1_weights = [[]]
var best_layer1_bias = []

var best_layer2_weights = [[]]
var best_layer2_bias = []

var best_layer3_weights = [[]]
var best_layer3_bias = []
