extends StateMachine

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
