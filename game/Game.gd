extends Node

const Stage1 = preload("res://game/stages/Stage1.tscn")
const Stage2 = preload("res://game/stages/Stage2.tscn")
const Stage3 = preload("res://game/stages/Stage3.tscn")
const Stage4 = preload("res://game/stages/Stage4.tscn")
const Stage5 = preload("res://game/stages/Stage5.tscn")
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
	$Turn.set_text(current_turn + " now playing")
	
	rpc("won_game")
	rpc("who_won_stg")

sync func who_won_stg():
	if $HeresUI.points >= 15:
		rpc("h_won_curr_stg")
		$HeresUI.points = 0
		rpc("send_curr_and_lst_stg")
		
	if $YetziraUI.points >= 15:
		rpc("y_won_curr_stg")
		$YetziraUI.points = 0
		rpc("send_curr_and_lst_stg")

func _on_End_Turn_pressed():
	rpc("end_turn")

sync func end_turn():
	if current_turn == "Yetzira":
		current_turn = "Heres"
		$YetziraUI.CP = 10
	else:
		current_turn = "Yetzira"
		$HeresUI.DP = 10
		
sync func send_curr_and_lst_stg():
	emit_signal("send_current_and_last_stage", current_stage, last_stage)
		
sync func won_game():
	if current_stage > 5:
		rpc("y_won_game")
	elif current_stage < 1:
		rpc("h_won_game")
		
sync func h_won_game():
	$Heres_Won.show()
	
sync func y_won_game():
	$Yetzira_Won.show()
		
sync func h_won_curr_stg():
	last_stage = current_stage
	current_stage -= 1
	$Heres_won_stg.show()
	emit_signal("start_H_timer")
	
sync func y_won_curr_stg():
	current_stage += 1
	$Yetzira_won_stg.show()
	emit_signal("start_Y_timer")

