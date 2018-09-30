extends Control

onready var DP = 10
onready var points = 0
onready var flag = false

func _ready():
	get_node("Stage3_Skills").show()

func _process(delta):
	get_points()
	
	if DP <= 0 and !flag:
		$No_Points.show()
		$No_Points/no_points_timer.start()
		flag = true
		
func _on_Game_send_current_and_last_stage(curr_stg, lst_stg):
	if curr_stg < 6:
		get_node("Stage" + str(lst_stg) + "_Skills").hide()
		get_node("Stage" + str(curr_stg) + "_Skills").show()

		
func _on_no_points_timer_timeout():
	$No_Points.hide()
	$No_Points/no_points_timer.stop()

func get_points():
	if Input.is_action_just_pressed("left_mouse"):
		points += 5

func _on_Atom_pressed():
	DP -= 1

func _on_Molecule_pressed():
	DP -= 3

func _on_Compound_pressed():
	DP -= 5

func _on_Cell_pressed():
	DP -= 1

func _on_Tissue_pressed():
	DP -= 3

func _on_Organ_pressed():
	DP -= 5

func _on_People_pressed():
	DP -= 1

func _on_Crowd_pressed():
	DP -= 3

func _on_Building_pressed():
	DP -= 5

func _on_Village_pressed():
	DP -= 1

func _on_City_pressed():
	DP -= 3

func _on_Country_pressed():
	DP -= 5

func _on_Planet_pressed():
	DP -= 1

func _on_System_pressed():
	DP -= 3

func _on_Galaxy_pressed():
	DP -= 5
