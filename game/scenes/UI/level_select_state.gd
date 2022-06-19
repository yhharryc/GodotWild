extends State

export(NodePath) var level_selection_path
onready var level_selection = get_node(level_selection_path)

func enter ():
	level_selection.visible=true
	
	level_selection.set_buttons_disabled(false)
	owner.GUI.anim.play("light_shader_fade_in")
	yield(owner.GUI.anim,"animation_finished")
	

	
func exit():
	level_selection.visible=false
	owner.GUI.anim.play("light_shader_fade_out")
	yield(owner.GUI.anim,"animation_finished")
	
	
func handle_input(event):
	if event.is_action_pressed("escape") :
		print_debug("hello")
		emit_signal("finished","title_screen")
	elif event.is_action_pressed("right_click"):
		emit_signal("finished","title_screen")
