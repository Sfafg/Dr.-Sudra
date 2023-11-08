extends Node2D
var current_scene_node;

func _ready():
	current_scene_node = get_node("CurrentScene")

	
func _on_politechnika_player_entered():
	_load_scene("res://Scenes/Transition.tscn")


func _load_scene(scene_path:String):
	# Remove the current level
	if(current_scene_node == null):
		return
		
	remove_child(current_scene_node)
	current_scene_node.call_deferred("free")
#
#	# Add the next level
	var next_scene = load(scene_path).instantiate()
	next_scene.name = "CurrentScene"
	add_child(next_scene)
