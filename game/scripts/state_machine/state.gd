extends Node
class_name State

signal finished(next_state_name)

onready var player = get_parent().get_node(get_parent().player)
func enter():
	pass

func exit():
	pass

func handle_input(_event):
	pass

func update(_delta):
	pass

func _on_animation_finished(_anim_name):
	pass
