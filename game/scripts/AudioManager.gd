extends AudioStreamPlayer

func _ready():
	AudioManager.pause_mode=Node.PAUSE_MODE_PROCESS
