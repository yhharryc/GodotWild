extends Node2D
class_name Level

signal level_cleared(level,time_used)
var duration = 0
var start_time
var index
var is_active = true
onready var player = $Player
onready var respawnPoint = $RespawnPoint
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	start_time = OS.get_system_time_msecs()
	print_debug(start_time)

func _ready():
	print_debug("Level "+String(index+1)+" Entered")
	yield(player,"character_ready")
	player.connect("character_dead",self,"_on_player_dead")
	respawnPoint.global_position = player.global_position
	duration = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	pass

func get_time_passed():
	return Time.new(OS.get_system_time_msecs() - start_time)

func _on_Area2D_body_exited(body):
	if body.name =="Player"&&is_active:
		print_debug("NEXT STAGE")
		emit_signal("level_cleared",self, Time.new(OS.get_system_time_msecs() - start_time))
	pass # Replace with function body.

func _on_player_dead():
	owner.reload_current()
	pass



class Time:
	var raw_time
	var hour
	var minute
	var sec
	var msec
	var time
	func _init(raw_time):
		time =msec_to_time(raw_time)
		pass
	
	func msec_to_time(time):
		msec = fmod(time,1000)
		var temp = (time - msec)/1000
		if msec<10:
			msec ="00"+ String(msec)
		elif msec<100:
			msec ="0"+ String(msec)
		
		sec = fmod(temp,60)
		temp = (temp - sec)/60
		if sec<10:
			sec ="0"+ String(sec)
		minute = fmod(temp,60)
		temp = (temp - minute)/60
		if minute<10:
			minute ="0"+ String(minute)
		hour = min(temp,99)
		if hour<10:
			hour ="0"+ String(hour)
		time = String(hour)+":"+String(minute)+":"+String(sec)+":"+String(msec)
		return time
	
	pass
