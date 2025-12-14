extends CharacterBody2D

const SPEED = 200.0

# Health system
var health: float = 100.0
var max_health: float = 100.0
var invincible: bool = false
var invincibility_duration: float = 0.5


func _ready():
	add_to_group("player")
	print("Player health: ", health)

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	move_and_slide()

# Funktion til at modtage skade
func take_damage(amount: float):
	if invincible:
		return  # Ignorer skade hvis invincible
		
	health -= amount
	print("Player took ", amount, " damage! Health: ", health, "/", max_health)
	
	# Start invincibility
	invincible = true
	get_tree().create_timer(invincibility_duration).timeout.connect(func(): invincible = false)
	
	if health <= 0:
		die()

		

func die():
	print("Player died!")
	# Valgfrit: Reload scene eller vis game over
	get_tree().reload_current_scene()
	# eller: queue_free()


	
