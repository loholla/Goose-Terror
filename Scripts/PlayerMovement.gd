extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var biting = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir = Input.get_axis("Left","Right")
	if dir == 1 and !GameManager.biting:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Walking")
	elif dir == -1 and !GameManager.biting:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Walking")
	elif !GameManager.biting:
		$AnimatedSprite2D.play("Idle")
		
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if direction == 0:
			$AnimatedSprite2D.play("StationaryBite")
		else:
			$AnimatedSprite2D.play("WalkingBite")
		BiteTimer()
	

	move_and_slide()

func BiteTimer():
	GameManager.biting = true
	$BiteTime.start()


func _on_bite_time_timeout():
	GameManager.biting = false

func Player():
	pass
