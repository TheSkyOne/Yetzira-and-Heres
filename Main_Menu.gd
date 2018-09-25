extends Node


func _process(delta):	
	if Network.amount_connected == Network.MAX_PLAYERS:
		get_tree().set_refuse_new_network_connections(true)
		$Waiting.hide()
		load_game()
	
func _on_Server_IP_text_changed(new_text):
	Network.SERVER_IP = new_text
	
func _on_Port_text_changed(new_text):
	new_text = int(new_text)
	Network.SERVER_PORT = new_text

func on_Create_Lobby_pressed():
	Network.create_server()
	$Waiting.show()
	$menu_screen/Create_Lobby.set_disabled(true)
	$menu_screen/Join_Lobby.set_disabled(true)

func on_Join_Lobby_pressed():
	if Network.there_is_server:
		Network.connect_to_server()
		$Waiting.show()
		$menu_screen/Create_Lobby.set_disabled(true)
		$menu_screen/Join_Lobby.set_disabled(true)
	else: 
		$no_server_err/Error.set_text("A SERVER HASNT BEEN INITIALIZED")
		$no_server_err.show()
		
func _on_Waiting_Close_pressed():
	$Waiting.hide()
	
func _on_Error_Close_pressed():
	$no_server_err.hide()

func load_game():
	get_tree().change_scene("res://Game.tscn")
