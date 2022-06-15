extends Node2D
class_name Level

signal level_cleared(level)

var index
onready var player = $Player
onready var respawnPoint = $RespawnPoint
# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Level "+String(index+1)+" Entered")
	yield(player,"character_ready")
	player.connect("character_dead",self,"_on_player_dead")
	respawnPoint.global_position = player.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_exited(body):
	if body.name =="Player":
		print_debug("NEXT STAGE")
		emit_signal("level_cleared",self)
	pass # Replace with function body.

func _on_player_dead():
	# wait for dying animation finish
	# move player to respawn point
	player.global_position = respawnPoint.global_position
	# wait til respawn state
	pass
