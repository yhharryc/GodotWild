extends State
class_name PlayerState

onready var player = get_parent().get_parent()
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

func play_anim(anim_name):
	var anim_player:AnimationPlayer
	anim_player = player.get_node("AnimationPlayer")
	anim_player.play(anim_name)
	pass

func _on_character_dead():
	
	pass
