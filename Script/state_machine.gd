extends Node
@export var initial_state: EnemyState
@export var actor: CharacterBody2D  # fjenden

var current_state: EnemyState
var states: Dictionary = {}

func _ready():
	print("StateMachine parent:", self.get_parent())
	# Find alle child-states og tilføj til states mit Dictionary
	for child in get_children():
		if child is EnemyState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			
	# Sæt initial state én gang
	if initial_state:
		current_state = initial_state
		current_state.actor = self.get_parent()  # sæt actor
		current_state.enter()


func _process(delta):
	# delta er tiden siden sidste frame i sekunder!
	if current_state:
		current_state.update(delta)


func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func on_child_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if new_state:
		if current_state:
			current_state.exit()

	#	new_state.actor = self   # ← vigtig linje
		new_state.actor = self.get_parent()  # parent = CharacterBody2D
	#	new_state.actor = actor
	#	print("!!!!!!!!!!!!!!!!!!!!!!!!!Actor: 50", new_state.actor)
	else:
		print("error no state 52")


	new_state.enter()
	current_state = new_state
