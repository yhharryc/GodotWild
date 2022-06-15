extends KinematicBody2D

export(float) var max_walk_speed = 450
export(float) var max_run_speed = 700
export(float) var maxJumpHeight = 120
export(float) var maxHoldJumpHeight = 180
export(float) var maxJumpTime = 0.5
export(float) var in_air_jump_window = 0.2
export(float) var on_ground_jump_window = 0.2
var max_jumps = 1
var jump_count = 0
var in_air_jump_timer
var on_ground_jump_timer 
var initialJumpVelocity
var maxJumpVelocity
var gravity = -9.8
var velocity = Vector2()
var applied_velocity = Vector2()
#signals
signal direction_changed(new_direction)
signal velocity_recorded
signal character_moved
signal friend_spotted(source,friend)
signal character_ready
signal character_dead

var look_direction = Vector2.RIGHT setget set_look_direction
# Called when the node enters the scene tree for the first time.
func _init():
	pass

func can_in_air_jump():
	if jump_count<max_jumps&&(in_air_jump_timer &&in_air_jump_timer.time_left>0):
		return true
	return false
	pass

func can_on_ground_jump():
	if jump_count<max_jumps&&(on_ground_jump_timer&&on_ground_jump_timer.time_left>0):
		return true
	return false


func _ready():
	setup_jump_variables()
	emit_signal("character_ready")
	pass # Replace with function body.

func _physics_process(delta):
	velocity = applied_velocity
	emit_signal("velocity_recorded")
	yield(get_node("StateMachine"),"state_processed")
	move_and_slide(self.applied_velocity, Vector2.UP, 5, 2)
	if get_slide_count():
		var collision_info = get_slide_collision(0)
	emit_signal("character_moved")

func get_walk_speed()->float:
	return max_walk_speed
	pass

func get_current_state():
	return $StateMachine.current_state


func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func is_grounded():
	return is_on_floor()
	
func setup_jump_variables():
	var timeToApex = maxJumpTime/2
	gravity = (-2*maxJumpHeight)/pow(timeToApex,2)
	initialJumpVelocity = (2*maxJumpHeight)/timeToApex
	maxJumpVelocity = (2*maxHoldJumpHeight)/timeToApex

func _on_Player_direction_changed(new_direction):
	if new_direction.x!=0:
		$Sprite.scale.x = new_direction.x *abs($Sprite.scale.x)
		$ViewZone.scale.x = new_direction.x *abs($ViewZone.scale.x)
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	emit_signal("friend_spotted",self,body)
	body.visible = true
	body.set_physics_process(false)
	pass # Replace with function body.


func _on_ViewZone_body_exited(body):
	#body.visible = false
	body.set_physics_process(true)
	pass # Replace with function body.
	

