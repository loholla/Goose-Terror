extends CharacterBody2D

var moveLeft = false
var moveRight = false
var idleL = true
var idleR = false

var idleAnim = null
var walkAnim = null

const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$IdleLeft.start()
	var num = randi_range(1,8)
	match(num):
		1:
			idleAnim = "C1Idle"
			walkAnim = "C1Walk"
		2:
			idleAnim = "C2Idle"
			walkAnim = "C2Walk"
		3:
			idleAnim = "C3Idle"
			walkAnim = "C3Walk"
		4:
			idleAnim = "C4Idle"
			walkAnim = "C4Walk"
		5:
			idleAnim = "D1Idle"
			walkAnim = "D1Walk"
		6:
			idleAnim = "D2Idle"
			walkAnim = "D2Walk"
		7:
			idleAnim = "D3Idle"
			walkAnim = "D3Walk"
		8:
			idleAnim = "D4Idle"
			walkAnim = "D4Walk"
		

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if idleL:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play(idleAnim)
		velocity.x = 0
	elif idleR:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play(idleAnim)
		velocity.x = 0
	elif moveLeft:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play(walkAnim)
		velocity.x = -SPEED
	elif moveRight:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play(walkAnim)
		velocity.x = SPEED
	move_and_slide()


func _on_idle_left_timeout():
	$MoveRight.start()
	idleL = false
	moveRight = true


func _on_move_right_timeout():
	$IdleRight.start()
	idleR = true
	moveRight = false


func _on_idle_right_timeout():
	$MoveLeft.start()
	idleR = false
	moveLeft = true


func _on_move_left_timeout():
	$IdleLeft.start()
	moveLeft = false
	idleL = true


func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		GameManager.gooseDied()
