extends StaticBody2D

func _on_area_2d_body_entered(body):
	GameManager.load_scene("res://Scenes/TestScene.tscn")
