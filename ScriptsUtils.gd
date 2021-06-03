const ScriptManager = preload("./ScriptManager.gd")
const ScriptsRepository = preload("./ScriptsRepository.gd")

static func collect_scripts(node: Node, scripts := Array(), repository := ScriptsRepository.new(), limit := 1000) -> ScriptsRepository:
	var maybe_script: Reference = node.get_script()
	if maybe_script != null:
		var script: GDScript = maybe_script
		var path = script.resource_path.get_file().replace(".gd", "")
		if scripts.size() == 0 or scripts.find(path) > -1:
			repository.add_script(script, node)
	if limit > 0:
		limit -= 1
		for child in node.get_children():
			collect_scripts(child, scripts, repository, limit)
	return repository

static func pause_scene(node: Node, pause := true, limit := 1000) -> void:
	node.set_process(not pause)
	node.set_physics_process(not pause)
	node.set_process_input(not pause)
	node.set_process_internal(not pause)
	node.set_process_unhandled_input(not pause)
	node.set_process_unhandled_key_input(not pause)
	if limit > 0:
		limit -= 1
		for child in node.get_children():
			pause_scene(child, pause, limit)
