extends EnemyState
class_name EnemyIdle





var move_direction: Vector2
var wander_time: float

func randomize_wander():
	#print("Entered randomize_wander 14")
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1,3)
	
func enter(_msg := {}):
	print("ENTER IDLE — No Target")
	randomize_wander()

func update(delta: float):
	if wander_time>0:
		wander_time -= delta
	else: 
		randomize_wander()
		# Tjek for spiller
	#if not actor:
	#	return
	if actor:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var distance = actor.global_position.distance_to(player.global_position)
	#		print(chase_distance)
			if distance < chase_distance:
				print(distance,"SÅ!! ",chase_distance)
				emit_signal("transitioned", "enemyrun")  # Skift state til EnemyRun
	else:
			print("ERROR ACTOR")

func physics_update(_delta: float):
	if actor:
		actor.velocity = move_direction * move_speed
		actor.move_and_slide()
		print("Player found: ", actor)  # ✅ Er spilleren fundet?


		
func perform_attack():
	print("Enemy attacks the player!")
	if sprite:
		sprite.play("Kick")
