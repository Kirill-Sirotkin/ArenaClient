extends Node

@onready var Network = $".."
@onready var Self = $"."

func _ready() -> void:
	Network.connection_server_ok.connect(_on_connection_server_ok)

func _on_button_pressed() -> void:
	Network.join_game()

func _on_connection_server_ok() -> void:
	SceneTransition.change_scene(Self, "LobbyMenu", Network)
