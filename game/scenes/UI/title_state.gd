extends State

export(NodePath) var title_path
onready var title_screen = get_node(title_path)

func enter():
	title_screen.visible=true
	yield(get_parent().get_parent(),"GUI_ready")
	owner.GUI.anim.play("light_shader_fade_in")
	yield(owner.GUI.anim,"animation_finished")
	
	pass

func _on_New_Game_pressed():
	owner.GUI.anim.play("light_shader_fade_out")
	yield(owner.GUI.anim,"animation_finished")

	emit_signal("finished","level_selection")
	pass # Replace with function body.

func exit():
	title_screen.visible = false
	pass
