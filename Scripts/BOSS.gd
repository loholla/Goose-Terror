extends CharacterBody2D

var player = null
var jumpChance

const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if player != null:
		if player.position.x > self.position.x:
			velocity.x = 1 * SPEED
		elif player.position.x < self.position.x:
			velocity.x = -1 * SPEED
		else:
			velocity.x = 0
	
	jumpChance = randi_range(1, 100)
	if jumpChance > 75:
		velocity.y = SPEED
	
	move_and_slide()


func _on_player_detector_body_entered(body):
	if body.has_method("Player"):
		player = body


func _on_player_dies_body_entered(body):
	if body.has_method("Player"):
		GameManager.gooseDied()
