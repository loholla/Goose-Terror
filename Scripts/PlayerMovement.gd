extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var biting = false
var dJed = false
var dash = false
var dashCool = false
var canBite = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handles the jumping action and skills
	if GameManager.skillFlap: # Allows the player to jump infinitely
		if Input.is_action_just_pressed("Up"):
			velocity.y = JUMP_VELOCITY
	elif GameManager.skillDJ: # Allows the player to jump twice before they must land
		if Input.is_action_just_pressed("Up") and (is_on_floor() or !dJed):
			dJed = true
			velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("Up") and is_on_floor(): # Only lets the player jump once
		velocity.y = JUMP_VELOCITY
	if is_on_floor():
		dJed = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir = Input.get_axis("Left","Right")
	if dir == 1 and !GameManager.biting: # This block is all for playing the regular animations when not biting people
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Walking")
	elif dir == -1 and !GameManager.biting:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Walking")
	elif !GameManager.biting:
		$AnimatedSprite2D.play("Idle")
		
	var direction = Input.get_axis("Left", "Right")
	if direction:
		if dash: # if dash is true, doubles the SPEED const for faster movement
			velocity.x = direction * SPEED * 2
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): # BITE. CHOMP. HONK
		if canBite:
			$HonkDelay.start()
			canBite = false
			if direction == 0:
				$AnimatedSprite2D.play("StationaryBite")
			else:
				$AnimatedSprite2D.play("WalkingBite")
			BiteTimer()
			$BiteCooldown.start()
	
	# Dash skill. Currently not bound correctly.
	if Input.is_action_just_pressed("Dash") and GameManager.skillDash:
		if !dashCool:
			dash = true
			$DashTimer.start()

	move_and_slide()

func BiteTimer():
	GameManager.biting = true
	$BiteTime.start()


func _on_bite_time_timeout():
	GameManager.biting = false

func Player():
	pass


func _on_dash_timer_timeout():
	$DashCooldown.start()
	dash = false
	dashCool = true


func _on_dash_cooldown_timeout():
	dashCool = false


func _on_bite_cooldown_timeout():
	canBite = true


func _on_honk_delay_timeout():
	$Honk.play()
