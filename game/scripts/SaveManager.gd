extends Node

var save_path = "user://save.dat"
export(Array) var levels 
var level_data ={
	
}
# Called when the node enters the scene tree for the first time.
func _ready():
	levels =[
		"res://game/scenes/Levels/Level1.tscn",
		"res://game/scenes/Levels/Level2.tscn",
		"res://game/scenes/Levels/Level3.tscn",
		"res://game/scenes/Levels/Level4.tscn",
		"res://game/scenes/Levels/Level5.tscn",
		"res://game/scenes/Levels/Level6.tscn",
		"res://game/scenes/Levels/Level7.tscn"
	]
	pass # Replace with function body.

func save_game():
	var data = {}
	for index in level_data.keys():
		data[index] = level_data[index].raw_time
	
	var file = File.new()
	var error = file.open(save_path,File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()

func load_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path,File.READ)
		if error == OK:
			var player_data = file.get_var()
			load_player_data(player_data)
		file.close()
		
func load_player_data(data:Dictionary):
	for index in data.keys():
		level_data[index] = Level.Time.new(data[index]) 
	

