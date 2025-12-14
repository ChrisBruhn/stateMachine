extends CharacterBody2D
@export var player: Node2D


# Reference til din statemachine (så den kan kalde physics_update)
@onready var state_machine = $StateMachine

func _physics_process(delta):
	# State-machine physics update
	if state_machine:
		state_machine._physics_process(delta)
	
	# CharacterBody2D movement
	move_and_slide()
