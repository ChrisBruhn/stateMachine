
	



extends EnemyState
class_name EnemyAttack

var attack_cooldown: float = 1.0
var cooldown_timer: float = 0.0
var has_attacked: bool = false

func enter(_msg := {}):
	cooldown_timer = 0.0
	if not target or not is_instance_valid(target):
		target = get_tree().get_first_node_in_group("player")

	has_attacked = false
	
	if sprite:
		sprite.play("Kick")
		
		if not sprite.animation_finished.is_connected(_on_kick_finished):
			sprite.animation_finished.connect(_on_kick_finished)

func _on_kick_finished():
	if sprite.animation == "Kick" and not has_attacked:
		deal_damage()
		has_attacked = true

func deal_damage():
	if target and is_instance_valid(target):
		var distance = actor.global_position.distance_to(target.global_position)
		
		if distance <= attack_range:
			if target.has_method("take_damage"):
				target.take_damage(10)

func update(_delta: float):
	cooldown_timer += _delta
	if not is_instance_valid(target):
		emit_signal("transitioned", "enemyidle")
		return

	if not actor:
		return

	var distance = actor.global_position.distance_to(target.global_position)

	# Kun skift state hvis cooldown er færdig
	if cooldown_timer >= attack_cooldown:
		if distance > attack_range and distance < chase_distance:
			emit_signal("transitioned", "enemyrun")
			return


	# Hvis spilleren er langt væk → Idle
	if distance > chase_distance:
		emit_signal("transitioned", "enemyidle")
		return

func physics_update(_delta: float):
	if actor:
		actor.velocity = Vector2.ZERO

func exit():
	if sprite and sprite.animation_finished.is_connected(_on_kick_finished):
		sprite.animation_finished.disconnect(_on_kick_finished)
