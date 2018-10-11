extends Node

onready var x = randi()%1
onready var current_stage = 0
onready var last_stage = 0
var current_turn = ""
signal send_current_and_last_stage()
signal start_Y_timer()
signal start_H_timer()

func _ready():
	current_stage = 3
	
	if Network.is_host:
		$HostorPlayer.set_text("Host")
	elif Network.is_host == false:
		$HostorPlayer.set_text("Player")

	Network.host_info.role = "Yetzira"
	Network.player_info.role = "Heres"
	current_turn = Network.host_info.role

		
	$Turn.set_text(current_turn + " now playing")
	
	if Network.is_host:
		$Role_display.set_text("You Are: " + Network.host_info.role)
	else:
		$Role_display.set_text("You Are: " + Network.player_info.role)

func _process(delta):
	rpc("set_end_turn_disabled")
	rpc("won_game")
	rpc("who_won_stg")

sync func set_end_turn_disabled():
	match current_turn:
			"Yetzira":
				if Network.is_host:
					$End_Turn.set_disabled(Network.host_info.role == "Heres")
				else:
					$End_Turn.set_disabled(Network.player_info.role == "Heres")
					
			"Heres":
				if Network.is_host:
					$End_Turn.set_disabled(Network.host_info.role == "Yetzira")
				else:
					$End_Turn.set_disabled(Network.player_info.role == "Yetzira")
	

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
		
	$Turn.set_text(current_turn + " now playing")
	
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