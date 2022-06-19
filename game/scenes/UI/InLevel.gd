extends State

export(NodePath) var inLevelPath
onready var inLevel = get_node(inLevelPath)
export(NodePath) var titleShaderPath
onready var titleShader = get_node(titleShaderPath)
export (NodePath) var pausePath
onready var pause_screen = get_node(pausePath)
export (NodePath) var shaderPath
onready var shader = get_node(shaderPath)


func enter():
	
	inLevel.get_node("PauseMenu").visible = false
	inLevel.visible = true
	titleShader.visible = false
	shader.visible = true
	owner.GUI.anim.play("light_shader_fade_in")
	yield(owner.GUI.anim,"animation_finished")
	pass


func handle_input(event):
	if event.is_action_pressed("escape"):
		print_debug("hello")
		if not get_tree().paused:
			pause_screen.visible = true
			print_debug(pause_screen.visible)
			get_tree().paused = true
		elif get_tree().paused:
			pause_screen.visible = false
			print_debug(pause_screen.visible)
			get_tree().paused = false



func exit():
	inLevel.get_node("PauseMenu").visible = false
	titleShader.visible = true
	
	owner.GUI.anim.play("light_shader_fade_out")
	yield(owner.GUI.anim,"animation_finished")
	get_tree().paused = false
	

	owner.owner.quit_game()
	inLevel.visible = false
	shader.visible = false
	print_debug(owner.owner.scene_instance)
	
	pass

func update(_delta):
	if owner.owner.get_player_position():
		
		shader.material.set_shader_param("player_position",owner.owner.get_player_position())

