extends Node

@onready var Network = $".."

func _ready() -> void:
	Network.connection_server_ok.connect(_on_connected_server_ok)
	Network.connection_server_fail.connect(_on_connected_server_fail)
	Network.server_disconnected.connect(_on_server_disconnected)
	Network.server_message.connect(_on_server_message)

func _on_connected_server_ok() -> void:
	print("Connected to server")

func _on_connected_server_fail() -> void:
	print("Failed to connect to server")

func _on_server_disconnected() -> void:
	print("Server disconnected")

func _on_server_message(msg: String) -> void:
	#print("SERVER: ", msg)
	pass
