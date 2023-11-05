extends Node

@export var items_array:Array[Resource] = []

func _ready():
	randomize()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):   
		var randomPicker = RandomPicker.new()    
		print(randomPicker.pick_random_item(items_array))
