extends Node2D

##
#	
# [[fileName, is_looping:bool]]
#	
##
var play_list = [[],[],[],[]]

func _ready():
	var index = 0
	for child in get_children():
		child.connect("stream_finished",self,"_on_stream_player_finished")
		child.index = index
		index+=1
	pass # Replace with function body.


func play(filePath,is_looping):
	var i = 0
	for player in play_list:
		##can play here
		if player.empty():
			get_child(i).stream = load(filePath)
			get_child(i).play()
			print_debug(get_child(i))
			player.append(filePath)
			player.append(is_looping)
			
			return 
			pass
			
		i+=1
		
		pass
	pass
	
func stop(filePath):
	var i = 0
	for player in play_list:
		
		if !player.empty() && player[0] == filePath:
			get_child(i).stop()
			player.clear()
		i+=1
	
	pass

func _on_stream_player_finished(index):
	var player = play_list[index]
	if not player[1]:
		player.clear()
	
	pass

