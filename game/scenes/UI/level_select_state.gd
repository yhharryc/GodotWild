extends State

export(NodePath) var level_selection_path
onready var level_selection = get_node(level_selection_path)

func enter ():
	level_selection.visible=true
	
	level_selection.set_buttons_disabled(false)
	owner.GUI.anim.play("light_shader_fade_in")
	yield(owner.GUI.anim,"animation_finished")
	
	
func update(_delta):
	pass
	
func exit():
	level_selection.visible=true
	pass
