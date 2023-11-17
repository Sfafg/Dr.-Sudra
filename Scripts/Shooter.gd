class_name Shooter
extends Node2D

const bulletPath = preload("res://Prefabs/Pocisk.tscn")

func shoot():
	var bullet = bulletPath.instantiate()
	
	get_tree().root.add_child(bullet)
	bullet.position = $"../Marker2D".global_position
