extends CharacterBody2D

# Speed and rotation speed
@export var moveSpeed: float = 200.0
@export var rotationSpeed: float = 3.0
@export var bullet_scene: PackedScene



# Movement direction vector
var velocityBetter2: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	# Reset velocity each frame
	velocityBetter2 = Vector2.ZERO

	# Handle forward and backward movement
	if Input.is_action_pressed("move_forward2"):
		velocityBetter2.y -= 1  # Moving forward
	if Input.is_action_pressed("move_backwards2"):
		velocityBetter2.y += 1  # Moving backward

	# Handle rotation
	if Input.is_action_pressed("rotate_left2"):
		rotation -= rotationSpeed * delta
	if Input.is_action_pressed("rotate_right2"):
		rotation += rotationSpeed * delta

	# Apply rotation to the velocity (but only after handling rotation)
	if velocityBetter2.length() > 0:
		velocityBetter2 = velocityBetter2.rotated(rotation) * moveSpeed

	# Move the tank using move_and_collide
	move_and_collide(velocityBetter2 * delta)
	
	
	
	
	
