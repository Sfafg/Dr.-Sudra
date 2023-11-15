extends Control



func _on_play_pressed():
	GameManager.load_scene("res://Scenes/MainScene.tscn")

func _on_options_pressed():
	GameManager.load_scene("res://Scenes/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
