extends StateMachine

#onready var jump = $Jump
#onready var stagger = $Stagger
export(NodePath) var player

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"in_air":$In_Air,
		"jump":$Jump,
		"die":$Die
	}
	owner.connect("character_dead", self, "_on_character_dead")

	


func _change_state(state_name):
	# The base state_machine interface this node extends does most of the work.
	if not _active:
		return
#	if state_name in ["stagger", "jump", "attack"]:
#		states_stack.push_front(states_map[state_name])
#	if state_name == "jump" and current_state == move:
#		jump.initialize(move.speed, move.velocity)
	._change_state(state_name)


func _unhandled_input(event):
	# Here we only handle input that can interrupt states, attacking in this case,
	# otherwise we let the state node handle it.
#	if event.is_action_pressed("attack"):
#		if current_state in [attack, stagger]:
#			return
#		_change_state("attack")
#		return
	current_state.handle_input(event)


func _on_character_dead():
	if current_state != states_map["die"]:
		current_state.emit_signal("finished","die")
	pass
