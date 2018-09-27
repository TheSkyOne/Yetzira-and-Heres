extends Node

var held = false

func _process(delta):
	for i in $ItemList.get_item_count():
		if held(i):
			print("hi")
	
func held(item):
		if Input.is_action_pressed("left_mouse") and $ItemList.is_selected(item): 
			return true
		if Input.is_action_just_released("left_mouse"):
			$ItemList.unselect(item)
			
			