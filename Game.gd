extends Node

onready var x = randi()%1

func _ready():
	
	if x == 0:
		Network.host_info.role = "Yetzira"
		Network.player_info.role = "Heres"
	else:
		Network.host_info.role = "Heres"
		Network.player_info.role = "Yetzira"	
	
	if Network.is_host:
		$Role_display.set_text("You Are: " + Network.host_info.role)
	else:
		$Role_display.set_text("You Are: " + Network.player_info.role)

