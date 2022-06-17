extends Node

var current_level = 0
var current_node
var level_scene
var scene_instance

	
onready var GUI = $CanvasLayer/GUI
var score_board = {}

func _ready():
	pass
	
	#load_level(0)

func _process(delta):
	if scene_instance:
		var time = scene_instance.get_time_passed()
		$CanvasLayer/GUI/InLevelScreen/TimePassed.text = time.time
	pass



func load_level(index:int):
	if index>=SaveManager.levels.size():
		print_debug("No such index for levels")
		return
	level_scene = load(SaveManager.levels[index])
	scene_instance = level_scene.instance()
	scene_instance.index = index
	scene_instance.connect("level_cleared",self,"_on_current_level_cleared")
	add_child(scene_instance)
	current_level = index
	current_node = scene_instance
	

func _on_current_level_cleared(level,time):
	print_debug("Level "+String(level.index+1)+" Cleared")
	SaveManager.level_data[level.index]=[time]
	score_board[level.index]= time
	var i = level.index+1
	if level.index+1<SaveManager.levels.size():
		yield(GUI.show_pop_label("LEVEL "+String(level.index+1)+" CLEARED"),"completed")
		remove_child(level)
		load_level(i)
	else:
		yield(GUI.show_pop_label("ALL LEVELS CLEARED"),"completed")
		GUI.return_to_title_screen()
		#print_debug("GAME OVER")
	pass

func reload_current():
	AudioManager.stream = load("res://game/resources/sounds/piano_kjf.mp3")
	AudioManager.play()
	scene_instance.is_active = false
	scene_instance.queue_free()
	##remove_child(scene_instance)
	load_level(current_level)
	pass

func restart():
	GUI.play_transition(self,"reload_current")

func get_player_position():
	if scene_instance:
		return Vector2(scene_instance.player.global_position.x/1200,scene_instance.player.global_position.y/900) 
	return null

func _on_level_selected(index):
	GUI._on_level_selected(index)

func quit_game():
	
	scene_instance.queue_free()
	scene_instance = null
	pass
