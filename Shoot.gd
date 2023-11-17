extends Node2D
class_name Shooting

const bulletPath = preload("res://Prefabs/Pocisk.tscn")

func shoot():
	var bullet = bulletPath.instance()
	
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
