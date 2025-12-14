extends Node
class_name State

signal transitioned(next_state: String)

var actor: Node = null

func enter(_msg := {}):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
