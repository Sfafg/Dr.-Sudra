extends Node

var current_scene = null;

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

	
func load_scene(scene_path:String):
	call_deferred("_diferred_load_scene", scene_path)


func _diferred_load_scene(scene_path:String):
	current_scene.free()
	
	current_scene = load(scene_path).instantiate()
	
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
