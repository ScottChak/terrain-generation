extends Spatial

const FlatNoiseGenerator = preload("res://scripts/noise_generators/FlatNoiseGenerator.gd")
const OpenSimplexNoiseGenerator = preload("res://scripts/noise_generators/OpenSimplexNoiseGenerator.gd")
const TerrainHeightGenerator = preload("res://scripts/TerrainHeightGenerator.gd")
const WorldChunk = preload("res://scripts/nodes/WorldChunk.gd")

enum NoiseType {Flat, OpenSimplex}

export(int) var terrain_chunk_size = 512
export(int) var terrain_base_height = 0
export(int) var terrain_max_height = 64
export(NoiseType) var terrain_noise_type = NoiseType.Flat

func _ready():
	add_world_chunk()

func _process(delta):
	$Rotate.rotate_y(delta * 0.2)
	
func add_world_chunk():
	var noise_generator
	
	match terrain_noise_type:
		NoiseType.OpenSimplex:
			var open_simplex_noise_generator = OpenSimplexNoiseGenerator.new(80, 6)
			open_simplex_noise_generator.base_height = terrain_base_height
			open_simplex_noise_generator.max_height = terrain_max_height
			noise_generator = open_simplex_noise_generator
		_:
			var flat_noise_generator = FlatNoiseGenerator.new()
			flat_noise_generator.base_height = terrain_base_height
			noise_generator = flat_noise_generator
	
	var terrain_height_generator = TerrainHeightGenerator.new()
	terrain_height_generator.chunk_size = terrain_chunk_size
	terrain_height_generator.noise_generator = noise_generator
	
	var world_chunk = WorldChunk.new()
	var terrain_material = load("res://materials/terrain.material")
	world_chunk.configure(terrain_height_generator, terrain_material)
	
	add_child(world_chunk)
