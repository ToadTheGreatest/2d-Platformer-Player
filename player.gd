extends CharacterBody2D

## How fast horizontally the player goes
@export var SPEED = 300.0
## How far up the player jumps (negative)
@export var JUMP_VELOCITY = -400.0
## How many frames not touching the ground until jumping it not possible (coyote time)
@export var MAX_COYOTE = 5

var coyote = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if coyote > 0:
			coyote -= 1
	
	if is_on_floor():
		coyote = MAX_COYOTE

	# Handle jump.
	if Input.is_action_just_pressed("up") and (is_on_floor() or coyote > 0):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		if Input.is_action_pressed("right"):
			$texture.play("up-right")
		elif Input.is_action_pressed("left"):
			$texture.play("up-left")
		else:
			$texture.play("up")
	elif Input.is_action_pressed("down"):
		if Input.is_action_pressed("right"):
			$texture.play("down-right")
		elif Input.is_action_pressed("left"):
			$texture.play("down-left")
		else:
			$texture.play("down")
	elif Input.is_action_pressed("right"):
		$texture.play("right")
	elif Input.is_action_pressed("left"):
		$texture.play("left")
	else:
		$texture.play("center")
