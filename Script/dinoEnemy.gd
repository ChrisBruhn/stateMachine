extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D

class_name DinoEnemy
func _physics_process(delta):
	move_and_slide()
	if velocity.length()>0:
		$AnimationPlayer.play("run") 	
	if velocity.x>0:
		$Sprite.flip_h=false
	else:
		$Sprite.flip_h=true
