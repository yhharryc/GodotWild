extends "res://game/scripts/state_machine/state.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter():
	play_anim("player_die")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta):
	
	handle_gravity()
	pass
#	pass

func handle_gravity():
	owner.applied_velocity.y -= player.gravity*get_physics_process_delta_time()
	
func _on_animation_finished(_anim_name):
	
	pass
