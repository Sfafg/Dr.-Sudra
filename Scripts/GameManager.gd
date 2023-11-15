extends Node

var current_scene = null;

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

	
func load_scene(scene_path:String):
	call_deferred("_diferred_load_scene", scene_path)


func _diferred_load_scene(scene_path:String):
	if not current_scene:
		current_scene = get_tree().current_scene
		
	current_scene.free()
	
	get_tree().root.add_child(load(scene_path).instantiate())
	current_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	get_tree().current_scene = current_scene


func execute_delayed(time_sec:float, function:Callable, args:Array = []):
	var f = func wait(): 
		await get_tree().create_timer(time_sec).timeout
		function.callv(args)
	f.call()
	
