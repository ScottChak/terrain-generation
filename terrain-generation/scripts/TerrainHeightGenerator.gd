extends Object

var chunk_size
var noise_generator

func get_mesh():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(chunk_size, chunk_size)
	plane_mesh.subdivide_depth = chunk_size * 0.5
	plane_mesh.subdivide_width = chunk_size * 0.5
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	
	var array_mesh = surface_tool.commit()
	
	var mesh_data_tool = MeshDataTool.new()
	mesh_data_tool.create_from_surface(array_mesh, 0)
	
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex = mesh_data_tool.get_vertex(i)
		
		if(noise_generator.has_method("get_noise")):
			vertex.y = noise_generator.get_noise(vertex.x, vertex.z)
		else:
			vertex.y = 0
		
		mesh_data_tool.set_vertex(i, vertex)
	
	for i in range(array_mesh.get_surface_count()):
		array_mesh.surface_remove(i)
	
	mesh_data_tool.commit_to_surface(array_mesh)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	
	return surface_tool.commit()
