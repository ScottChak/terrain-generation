extends Spatial

var size = 512
var height = 64

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.period = 80
	noise.octaves = 6
	
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size, size)
	plane_mesh.subdivide_depth = size * 0.5
	plane_mesh.subdivide_width = size * 0.5
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	
	var array_mesh = surface_tool.commit()
	
	var mesh_data_tool = MeshDataTool.new()
	mesh_data_tool.create_from_surface(array_mesh, 0)
	
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex = mesh_data_tool.get_vertex(i)
		vertex.y = noise.get_noise_3d(vertex.x, vertex.y, vertex.z) * height
		
		mesh_data_tool.set_vertex(i, vertex)
	
	for i in range(array_mesh.get_surface_count()):
		array_mesh.surface_remove(i)
	
	mesh_data_tool.commit_to_surface(array_mesh)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.set_surface_material(0, load("res://materials/terrain.material"))
	
	add_child(mesh_instance)

func _process(delta):
	$Rotate.rotate_y(delta * 0.2)
