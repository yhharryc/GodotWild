extends Control

onready var grid = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	
	for child in grid.get_children():		
		child.index = i
		child.connect("level_selected",owner,"_on_level_selected")
		#child.connect("level_selected",owner.get_node("CanvasLayer/GUI/GUI_State_Machine"),"_on_level_selected")
		child.connect("level_selected",self,"_on_level_selected")
		i+=1
	pass # Replace with function body.

func set_buttons_disabled(is_disabled):
	for child in grid.get_children():		
		child.disabled = is_disabled
		child.is_just_pressed = false
	pass
	

func _on_LevelSelectionScreen_visibility_changed():
	
	
	grid.get_child(0).is_locked = false
	for level_index in SaveManager.level_data.keys():
		grid.get_child(level_index).is_locked = false
		grid.get_child(level_index).best_score = SaveManager.level_data[level_index].time
		pass
	SaveManager.levels
	pass # Replace with function body.

func _on_level_selected():
	set_buttons_disabled(true)
