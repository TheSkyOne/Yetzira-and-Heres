extends Node

const YetziraUI = preload("res://Yetzira.tscn")
const HeresUI = preload("res://Heres.tscn")
const Stage1 = preload("res://Stage1.tscn")
const Stage2 = preload("res://Stage2.tscn")
const Stage3 = preload("res://Stage3.tscn")
const Stage4 = preload("res://Stage4.tscn")
const Stage5 = preload("res://Stage5.tscn")
onready var x = randi()%1
var current_turn = ""


func _ready():
	add_child(Stage3.instance())
	
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
			add_child(YetziraUI.instance())
		else:
			add_child(HeresUI.instance())
	else:
		if Network.player_info.role == "Yetzira":
			add_child(YetziraUI.instance())
		else:
			add_child(HeresUI.instance())
	
	
	if Network.is_host:
		$Role_display.set_text("You Are: " + Network.host_info.role)
	else:
		$Role_display.set_text("You Are: " + Network.player_info.role)

func _process(delta):
	$Turn.set_text(current_turn + " now playing")

func _on_End_Turn_pressed():
	rpc("end_turn")

sync func end_turn():
	if current_turn == "Yetzira":
		current_turn = "Heres"
	else:
		current_turn = "Yetzira"