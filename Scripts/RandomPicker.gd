extends Node
class_name RandomPicker

@export var items_list:Array[Resource] = []

func pick_random_item(items_array:Array = items_list):
	var chosen_value = null
	if items_array.size() > 0:
		#oblicz ogólną szansę
		var overall_chance: int = 0
		for item in items_array:
			if item.can_be_picked:
				overall_chance += item.PICK_CHANCE
		#Generuj losowy numer
		var random_number = randi() % overall_chance
		#Wybierz losowy item
		var offset:int = 0
		for item in items_array:
			if item.can_be_picked:
				if random_number < item.PICK_CHANCE + offset:
					chosen_value = item.VALUE
					break
				else :
					offset += item.PICK_CHANCE
		pass
	#Zwróć wartosc
	return chosen_value

