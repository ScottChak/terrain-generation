extends Spatial

const TerrainHeightGenerator = preload("res://scripts/TerrainHeightGenerator.gd")
const WorldChunk = preload("res://scripts/nodes/WorldChunk.gd")

var chunk_size = 512
var height = 64

func _ready():
	add_world_chunk()

func _process(delta):
	$Rotate.rotate_y(delta * 0.2)
	
func add_world_chunk():
	var terrain_height_generator = TerrainHeightGenerator.new(chunk_size, height)
	
	var world_chunk = WorldChunk.new()
	var terrain_material = load("res://materials/terrain.material")
	world_chunk.configure(terrain_height_generator, terrain_material)
	
	add_child(world_chunk)
