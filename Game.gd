extends Node

const Stage1 = preload("res://Stage1.tscn")
const Stage2 = preload("res://Stage2.tscn")
const Stage3 = preload("res://Stage3.tscn")
const Stage4 = preload("res://Stage4.tscn")
const Stage5 = preload("res://Stage5.tscn")
onready var x = randi()%1
onready var current_stage = 0
onready var last_stage = 0
var current_turn = ""
signal send_current_and_last_stage()
signal start_Y_timer()
signal start_H_timer()

func _ready():
	add_child(Stage3.instance())
	current_stage = 3
	
	if x == 0:
		Network.host_info.role = "Yetzira"
		Network.player_info.role = "Heres"
		current_turn = "Yetzira"
	else:
		Network.host_info.role = "Heres"
		Network.player_info.role = "Yetzira"	
		current_turn = "Heres"
		
		
	if Network.is_host:
		if Network.host_info.role == "Yetzira":
			$YetziraUI.show()
		else:
			$HeresUI.show()
	else:
		if Network.player_info.role == "Yetzira":
			$YetziraUI.show()
		else:
			$HeresUI.show()
	
	
	if Network.is_host:
		$Role_display.set_text("You Are: " + Network.host_info.role)
	else:
		$Role_display.set_text("You Are: " + Network.player_info.role)

func _process(delta):
	rpc("who_won_stg")
	$Turn.set_text(current_turn + " now playing")
		
	if current_stage > 5:
		$Yetzira_Won.show()
	elif current_stage < 1:
		$Heres_Won.show()

sync func switch_stage():
	last_stage = current_stage
	if $HeresUI.points >= 15:
		current_stage -= 1
	elif $YetziraUI.points >= 15:
		current_stage += 1
	emit_signal("send_current_and_last_stage", current_stage, last_stage)

sync func who_won_stg():
	if $HeresUI.points >= 15:
		rpc("switch_stage")
		$Heres_won_stg.show()
		$HeresUI.points = 0
		emit_signal("start_H_timer")
	elif $YetziraUI.points >= 15:
		rpc("switch_stage")
		$Yetzira_won_stg.show()
		$YetziraUI.points = 0
		emit_signal("start_Y_timer")
		
func _on_End_Turn_pressed():
	rpc("end_turn")

sync func end_turn():
	if current_turn == "Yetzira":
		current_turn = "Heres"
		$YetziraUI.CP = 10
	else:
		current_turn = "Yetzira"
		$HeresUI.DP = 10
		

