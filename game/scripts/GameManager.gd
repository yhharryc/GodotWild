extends Node

var current_level = 0
var level_scene
export(Array) var levels 
	
onready var GUI = $CanvasLayer/GUI

func _ready():
	levels =[
		"res://game/scenes/Levels/Level1.tscn",
		"res://game/scenes/Levels/Level2.tscn"
	
	]
	load_level(0)


func load_level(index:int):
	if index>=levels.size():
		print_debug("No such index for levels")
		return
	level_scene = load(levels[index])
	var scene_instance = level_scene.instance()
	scene_instance.index = index
	scene_instance.connect("level_cleared",self,"_on_current_level_cleared")
	add_child(scene_instance)
	

func _on_current_level_cleared(level):
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

