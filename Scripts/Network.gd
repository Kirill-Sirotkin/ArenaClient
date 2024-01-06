extends Node

# Client setup
const PORT: int = 7000
const DEFAULT_SERVER_IP: String = "127.0.0.1" # IPv4 localhost

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connection_server_ok)
	multiplayer.connection_failed.connect(_on_connection_server_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

signal connection_server_ok()
signal connection_server_fail()
signal server_disconnected()
signal server_message(msg: String)
signal client_disconnected()

# Own methods
#region
func join_game(address: String = "") -> void:
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, PORT)
	if error:
		print(error)
		return
	multiplayer.multiplayer_peer = peer

func leave_game() -> void:
	multiplayer.multiplayer_peer = null
	client_disconnected.emit()
#endregion

# Signal subscription methods
#region
func _on_connection_server_ok() -> void:
	connection_server_ok.emit()

func _on_connection_server_fail() -> void:
	connection_server_fail.emit()

func _on_server_disconnected() -> void:
	server_disconnected.emit()
#endregion

# RPCs
#region
@rpc("authority", "reliable")
func rpc_notify_all(msg: String) -> void:
	server_message.emit(msg)

@rpc("authority", "reliable")
func rpc_notify_peer(id: int, msg: String) -> void:
	server_message.emit(msg)

@rpc("any_peer", "reliable")
func rpc_send_player_info(info: String) -> void:
	pass

@rpc("any_peer", "reliable")
func rpc_send_chat(msg: String) -> void:
	pass
#endregion
