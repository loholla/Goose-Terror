extends CharacterBody2D

var direction
var player = null
var dir
var bitable = false


const SPEED = 5000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if bitable and GameManager.biting:
		$"Bit-Timer".start()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if player != null:
		direction = (player.position.x + self.position.x)
		if direction > 1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("Moving")
			dir = 1
		elif direction < 1:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Moving")
			dir = -1
		velocity.x = dir * SPEED * delta
	else:
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		player = body

func _on_area_2d_body_exited(body):
	if body.has_method("Player"):
		player = null


func _on_bite_area_body_entered(body):
	if body.has_method("Player"):
		bitable = true


func _on_bite_area_body_exited(body):
	if body.has_method("Player"):
		bitable = false


func _on_bit_timer_timeout():
	print("Person bit. Points added")
	self.queue_free()
	GameManager.score += 1
