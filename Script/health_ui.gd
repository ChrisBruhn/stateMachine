extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel

var player: CharacterBody2D = null

func _ready():
	# Find player
	player = get_tree().get_first_node_in_group("player")
	
	if player:
		# Opdater health bar ved start
		update_health_bar()

func _process(_delta):
	if player:
		update_health_bar()

func update_health_bar():
	if not player:
		return
	
	# Opdater progress bar
	health_bar.max_value = player.max_health
	health_bar.value = player.health
	
	# Opdater label
	health_label.text = str(int(player.health)) + " / " + str(int(player.max_health))
	
	# Skift farve baseret på health
	if player.health <= player.max_health * 0.25:
		health_bar.modulate = Color(1, 0, 0)  # Rød
	elif player.health <= player.max_health * 0.5:
		health_bar.modulate = Color(1, 0.5, 0)  # Orange
	else:
		health_bar.modulate = Color(0, 1, 0)  # Grøn
