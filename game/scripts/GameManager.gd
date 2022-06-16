extends Node

var current_level = 0
var current_node
var level_scene
var scene_instance
export(Array) var levels 
	
onready var GUI = $CanvasLayer/GUI
var score_board = {}

func _ready():
	levels =[
		"res://game/scenes/Levels/Level1.tscn",
		"res://game/scenes/Levels/Level2.tscn"
	
	]
	load_level(0)

func _process(delta):
	if current_node:
		var time = current_node.get_time_passed()
		$CanvasLayer/GUI/InLevelScreen/TimePassed.text = time.time
	pass


func load_level(index:int):
	if index>=levels.size():
		print_debug("No such index for levels")
		return
	level_scene = load(levels[index])
	scene_instance = level_scene.instance()
	scene_instance.index = index
	scene_instance.connect("level_cleared",self,"_on_current_level_cleared")
	add_child(scene_instance)
	current_level = index
	current_node = scene_instance
	

func _on_current_level_cleared(level,time):
	print_debug("Level "+String(level.index+1)+" Cleared")
	
	var i = level.index+1
	if level.index+1<levels.size():
		yield(GUI.show_pop_label("Level "+String(level.index+1)+" Cleared"),"completed")
		remove_child(level)
		load_level(i)
	else:
		yield(GUI.show_pop_label("All Levels Cleared"),"completed")
		print_debug("GAME OVER")
	pass

func reload_current():
	
	scene_instance.is_active = false
	scene_instance.queue_free()
	##remove_child(scene_instance)
	load_level(current_level)
	pass

func _unhandled_input(event):
	if event.is_action_pressed("debug_key"):
		GUI.play_transition(self,"reload_current")
		
