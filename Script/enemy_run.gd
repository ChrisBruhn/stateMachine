extends EnemyState
class_name EnemyRun




func enter(_msg := {}):
	if not target or not is_instance_valid(target):
		target = get_tree().get_first_node_in_group("player")
	print("ENTER RUN — Target is:", target)
	if sprite:
			sprite.play("Running")


func update(_delta: float):
	if not is_instance_valid(target):
		emit_signal("transitioned", "enemyidle")
		return

	if not actor:
		return

	var distance = actor.global_position.distance_to(target.global_position)
		
	# 2️⃣ Idle hvis for langt væk
	if distance > chase_distance:
		print("Favel")
		emit_signal("transitioned", "enemyidle")
		return
	# 1️⃣ Attack hvis tæt nok
	if distance < attack_range:
		emit_signal("transitioned", "enemyattack")
		return       

func physics_update(_delta: float):
	if actor and target:
		var direction = (target.global_position - actor.global_position).normalized()
		actor.velocity = direction * run_speed
		actor.move_and_slide() 
		# Spejlvend sprite
		if sprite:
			sprite.flip_h = direction.x < 0   # true hvis bevæger mod venstre
