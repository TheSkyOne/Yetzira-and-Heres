extends Node

var player_name = ""

func _process(delta):	
	if Network.amount_connected == Network.MAX_PLAYERS:
		get_tree().set_refuse_new_network_connections(true)
		$Waiting.hide()
		load_game()

func _on_Enter_Name_text_changed(new_text):
	player_name = new_text

func on_Create_Lobby_pressed():
	if player_name == "":
		return
		
	Network.create_server()
	$Waiting.show()
	$menu_screen/Create_Lobby.set_disabled(true)
	$menu_screen/Join_Lobby.set_disabled(true)

func on_Join_Lobby_pressed():
	if player_name == "":
		return
		
	Network.connect_to_server()
	$Waiting.show()
	$menu_screen/Create_Lobby.set_disabled(true)
	$menu_screen/Join_Lobby.set_disabled(true)
	
	
func _on_Close_pressed():
	$Waiting.hide()

func load_game():
	get_tree().change_scene("res://Game.tscn")
