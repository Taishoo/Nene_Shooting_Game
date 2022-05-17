extends Node

const save_path = "user://model.json"

const speed = 1
var mutation_rate = 0.2
var mutation_enabled = true

const GRAVITY:float = 30.00
var epoch_timer: int = 7

var CAN_MOVE:bool = true
var CAN_PAUSE:bool = true
var CAN_JUMP:bool = true

var points_on_hold:float = 0
var timer: int = 0

var data = {
    "epoch": 0,
    "generation": 0,
    "u_best": 0,
    "model": {
        "layer1_weights": [[]],
        "layer1_bias":[],
        "layer2_weights": [[]],
        "layer2_bias":[],
        "layer3_weights": [[]],
        "layer3_bias":[]
    }

}
