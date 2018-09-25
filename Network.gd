extends Node

const SERVER_PORT = 3297
const SERVER_IP = "127.0.0.1"
const MAX_PLAYERS = 2
var player_info = {name = "", role = ""}
var amount_connected = 0

func _process(delta):
	print(amount_connected)

func _ready():
	get_tree().connect("network_peer_connected", self, "player_connected")
	get_tree().connect("network_peer_disconnected", self, "player_disconnected")
	get_tree().connect("connected_to_server", self, "connected_ok")
	get_tree().connect("connection_failed", self, "connected_fail")
	get_tree().connect("server_disconnected", self, "server_disconnected")

func create_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(host)
	amount_connected += 1

func connect_to_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)

func player_connected(id):
	player_info.name = id
	if is_network_master():
		amount_connected += 1
	else: 
		amount_connected += 2
	var x = rand()%0+1
	if x == 0:
		player_info.role = "Yetzira"
	else:
		player_info.role = "Heres"
	
func player_disconnected(id):
    player_info.erase(id)
	
func connected_ok():	
	rpc("register_player", get_tree().get_network_unique_id(), player_info);
	
func connected_fail():
	print("error connecting")
	
func server_disconnected():
	get_tree().change_scene("res://Main_Menu.tscn")
	
remote func register_player(id, info):
	player_info[id] = info
	# If I'm the server, let the new guy know about existing players
	if get_tree().is_network_server():
	    rpc_id(id, "register_player", 1, player_info)
	    for peer_id in player_info:
	        rpc_id(id, "register_player", peer_id, player_info[peer_id])

