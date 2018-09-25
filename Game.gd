extends Node

func _ready():
	if Network.is_host:
		$Role_display.set_text("You Are: " + Network.host_info.role)
	else:
		$Role_display.set_text("You Are: " + Network.player_info.role)