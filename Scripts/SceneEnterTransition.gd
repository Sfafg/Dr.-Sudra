extends StaticBody2D
@export var scene_path : String

func _on_area_2d_body_entered(body):
	GameManager.load_scene(scene_path)
