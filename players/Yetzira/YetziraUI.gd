extends Control

onready var CP = 10
onready var points = 0
onready var flag = false

func _ready():
	get_node("Stage3_Skills").show()

func _process(delta):
	get_points()
	
	if CP <= 0 and !flag:
		$No_CP.show()
		$No_CP/no_cp_timer.start()
		flag = true

func get_points():
	if Input.is_action_just_pressed("ctrl"):
		points += 5
	
func _on_Game_send_current_and_last_stage(curr_stg, lst_stg):
	if curr_stg < 6 and curr_stg > 0:
		get_node("Stage" + str(lst_stg) + "_Skills").hide()
		get_node("Stage" + str(curr_stg) + "_Skills").show()

func _on_no_cp_timer_timeout():
	$No_CP.hide()
	$No_CP/no_cp_timer.stop()

func _on_Atom_pressed():
	CP -= 1

func _on_Molecule_pressed():
	CP -= 3

func _on_Compound_pressed():
	CP -= 5

func _on_Cell_pressed():
	CP -= 1

func _on_Tissue_pressed():
	CP -= 3

func _on_Organ_pressed():
	CP -= 5

func _on_Person_pressed():
	CP -= 1

func _on_Crowd_pressed():
	CP -= 3

func _on_Building_pressed():
	CP -= 5

func _on_Village_pressed():
	CP -= 1

func _on_City_pressed():
	CP -= 3

func _on_Country_pressed():
	CP -= 5

func _on_Planet_pressed():
	CP -= 1

func _on_System_pressed():
	CP -= 3

func _on_Galaxy_pressed():
	CP -= 5