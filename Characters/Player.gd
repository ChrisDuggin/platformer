extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animatedSprite = $AnimatedSprite2D
@onready var debugLabel = $DEBUG

var jumpReleased = true
var faceRight = true

func _physics_process(delta):
	if(velocity.x > 0):
		animatedSprite.flip_h = false
		faceRight = true
	elif(velocity.x < 0): 
		animatedSprite.flip_h = true
		faceRight = false

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if not is_on_wall():
			if(velocity.y <= 0):
				animatedSprite.animation = "jump"
			else: 
				animatedSprite.animation = "fall"
		else: 
			if(velocity.y <= 0):
				animatedSprite.animation = "fall"
	else: 
		if(velocity.x == 0):
			animatedSprite.animation = "idle"
		else: 
			animatedSprite.animation = "run"
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle Jump.
	if Input.is_joy_button_pressed(0, JOY_BUTTON_A) or Input.is_action_pressed("ui_accept"):
		if jumpReleased == true: 
			jumpReleased = false
			if is_on_floor():
				velocity.y = JUMP_VELOCITY	
	else: 
		jumpReleased = true

	move_and_slide()
