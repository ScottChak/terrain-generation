extends Node

var base_height
var max_height
var noise

func _init(period, octave):
	noise = OpenSimplexNoise.new()
	noise.period = period
	noise.octaves = octave

func get_noise(x, z):
	return base_height + (noise.get_noise_2d(x, z) * max_height)
