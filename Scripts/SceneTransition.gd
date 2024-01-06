extends CanvasLayer

@onready var Animator = $AnimationPlayer

func change_scene(old_scene: Node, new_scene_name: String, parent: Node) -> void:
	Animator.play("Fade")
	await Animator.animation_finished
	old_scene.queue_free()
	var scene_resource: PackedScene = load("res://Scenes/%s.tscn" % new_scene_name)
	var scene = scene_resource.instantiate()
	parent.add_child(scene)
	Animator.play_backwards("Fade")
