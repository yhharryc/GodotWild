extends Node


onready var fade_ins= {
	$BlackBackGround : ["color_rect_fade_in","color_rect_fade_out"],
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleShaderLayer.visible = true
	$InLevelScreen.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_shader_position()
	pass
func fade_in(node:Control):
	##node.modulate(0,0,0,1)
	node.visible = true
	if(fade_ins.has(node)):
		$AnimationPlayer.play(fade_ins[node][0])
		return true
		pass
	
	return false
	pass
	
func fade_out(node:Control):
	node.visible = false
	if (fade_ins.has(node)):
		$AnimationPlayer.play(fade_ins[node][1])
		return true	
	
	return false

func show_pop_label(message,time = 1.0):
	fade_in($BlackBackGround)
	$PopLabel.text = message
	if not(fade_in($PopLabel)):
		yield(get_tree().create_timer(time),"timeout")
	fade_out($BlackBackGround)
	fade_out($PopLabel)

func play_transition(source,method_to_call =""):
	$AnimationPlayer.play("color_rect_fade_in")
	yield($AnimationPlayer,"animation_finished")
	if method_to_call!="":
		source.call(method_to_call)
	$AnimationPlayer.play("color_rect_fade_out")
	yield($AnimationPlayer,"animation_finished")
	
func update_shader_position():
	if $InLevelScreen.visible:
		if owner.get_player_position():
			
			$ShaderLayer.visible = true
			$ShaderLayer.material.set_shader_param("player_position",owner.get_player_position())
		else:
			$ShaderLayer.visible = false
	


func _on_New_Game_pressed():
	print_debug("NEW GAME PRESSED")
	$AnimationPlayer.play("light_shader_fade_out")
	yield($AnimationPlayer,"animation_finished")
	#owner.load_level(0)
	$TitleScreen.visible = false
	$LevelSelectionScreen.visible = true
	$InLevelScreen/PauseMenu.visible = false
	$LevelSelectionScreen.set_buttons_disabled(!self.visible)
	
	$AnimationPlayer.play("light_shader_fade_in")
	yield($AnimationPlayer,"animation_finished")
	

func _on_level_selected(index):

	$AnimationPlayer.play("light_shader_fade_out")
	yield($AnimationPlayer,"animation_finished")
	
	owner.load_level(index)
	$TitleScreen.visible = false
	$LevelSelectionScreen.visible = false
	$InLevelScreen.visible = true
	update_best_record_ui(index)
	$InLevelScreen/PauseMenu.visible = false
	$TitleShaderLayer.visible = false
	$AnimationPlayer.play("light_shader_fade_in")
	yield($AnimationPlayer,"animation_finished")
	pass

func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func return_to_title_screen():
	$InLevelScreen/PauseMenu.visible = false
	$InLevelScreen.visible = false
	$AnimationPlayer.play("light_shader_fade_out")
	yield($AnimationPlayer,"animation_finished")
	owner.quit_game()
	$TitleScreen.visible = true
	$LevelSelectionScreen.visible = false
	$InLevelScreen/PauseMenu.visible = false
	$InLevelScreen.visible = false
	$TitleShaderLayer.visible = true
	$TitleShaderLayer.material.set_shader_param("player_position",Vector2(0.5,0.5))
	$TitleShaderLayer.material = load("res://game/resources/TitleShaderMaterial.tres")
	$AnimationPlayer.play("light_shader_fade_in")
	yield($AnimationPlayer,"animation_finished")
	
func _unhandled_input(event):
	if event.is_action_pressed("escape") and $InLevelScreen.visible:
		$InLevelScreen/PauseMenu.visible = true
		get_tree().paused = true
		

func _on_Resume_pressed():
	get_tree().paused = false
	$InLevelScreen/PauseMenu.visible = false
	pass # Replace with function body.


func _on_BacktoMain_pressed():
	$InLevelScreen/PauseMenu.visible = false
	$InLevelScreen.visible = false
	get_tree().paused = false
	return_to_title_screen()
	AudioManager.stream = load("res://game/resources/sounds/reload_sound_effect.mp3")
	AudioManager.play()
	pass # Replace with function body.


func _on_Restart_pressed():
	$InLevelScreen/PauseMenu.visible = false
	get_tree().paused = false
	owner.restart()
	pass # Replace with function body.

func update_best_record_ui(index):
	$InLevelScreen/VBoxContainer/BestRecord.visible = SaveManager.level_data.has(index)
	if SaveManager.level_data.has(index):
		$InLevelScreen/VBoxContainer/BestRecord.text = "Best: "+SaveManager.level_data[index].time
