extends StateMachine
signal changed_game_pause
var GUI


# Called when the node enters the scene tree for the first time.
func _ready():
	GUI = get_parent()
	states_map = {
		"title_screen":$TitleScreen,
		"level_selection":$LevelSelection,
		"in_level":$InLevel
	}
	
	pass # Replace with function body.

func _on_level_selected(index):
	if current_state == states_map["level_selection"]:
		_change_state("in_level")
	
	pass

func return_to_title_screen():
	_change_state("title_screen")
	pass

func _on_BacktoMain_pressed():
	
	_change_state("title_screen")
	
	pass # Replace with function body.
