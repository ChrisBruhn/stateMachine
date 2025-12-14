extends Node
class_name EnemyState

signal transitioned(next_state: String)
var sprite: AnimatedSprite2D
var actor: Node
var target: Node2D
var run_speed: float = 30.0
var move_speed: float = 5.0
var chase_distance: float = 100.0
var attack_range: float = 15.0

func enter(_msg := {}):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
