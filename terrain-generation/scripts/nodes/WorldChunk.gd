extends MeshInstance

func configure(mesh_provider, material):
	if(mesh_provider.has_method("get_mesh")):
		mesh = mesh_provider.get_mesh()
		
	set_surface_material(0, material)
