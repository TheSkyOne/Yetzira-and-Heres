extends Node

onready var x = randi()%1
const YetziraUI = preload("res://Yetzira.tscn")
const HeresUI = preload("res://Heres.tscn")

func _ready():
	if x == 0:
		Network.host_info.role = "Yetzira"
		Network.player_info.role = "Heres"
	else:
		Network.host_info.role = "Heres"
		Network.player_info.role = "Yetzira"	
		
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
