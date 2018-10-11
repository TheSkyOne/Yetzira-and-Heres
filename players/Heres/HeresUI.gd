extends Control

onready var DP = 10
onready var points = 0
onready var flag = false

func _ready():
	$Skills.show()
	
func _process(delta):
	get_points()
	
	if DP <= 0 and !flag:
		$No_DP.show()
		$No_DP/no_dp_timer.start()
		flag = true
	
func get_points():
	if Input.is_action_just_pressed("shift"):
		points += 5
	
func _on_no_dp_timer_timeout():
	$No_DP.hide()
	$No_DP/no_dp_timer.stop()

func _on_single_target_pressed():
	DP -= 1

func _on_AOE_pressed():
	DP -= 5

func _on_DOT_pressed():
	DP -= 3
