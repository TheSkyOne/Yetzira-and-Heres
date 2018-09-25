extends Node

const SERVER_PORT = 3297
const SERVER_IP = "127.0.0.1"
const MAX_PLAYERS = 2
onready var amount_connected = 0
var self_data = {name = ""}
var players = []

func _process(delta):
	print(amount_connected)

func _ready():
	get_tree().connect("network_peer_connected", self, "connected_to_server")
	get_tree().connect("network_peer_disconnected", self, "disconnected_from_server")

func create_server():
	var host = NetworkedMultiplayerENet.new()
	
	host.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(host)
	
func connect_to_server():
	var peer = NetworkedMultiplayerENet.new()
	
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	
func connected_to_server():
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info', get_tree().get_network_unique_id(), self_data)
	amount_connected += 1
	
func disconnected_from_server(id):
	players.erase(id)
	