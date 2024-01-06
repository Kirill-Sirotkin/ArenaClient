extends Node

@onready var Network = $".."
@onready var Self = $"."

func _ready() -> void:
	Network.client_disconnected.connect(_on_client_disconnected)

func _on_button_pressed() -> void:
	Network.leave_game()

func _on_client_disconnected() -> void:
	SceneTransition.change_scene(Self, "MainMenu", Network)
