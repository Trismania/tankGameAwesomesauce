extends CharacterBody2D

#Speed and rotation speed
@export var moveSpeed: float = 200.0
@export var rotationSpeed: float = 3.0
@export var bullet_scene: PackedScene  # Drag and drop the Bullet scene here in the inspector

#Movement direction vector
var velocityBetter: Vector2 = Vector2.ZERO

#Flag to track whether the shoot button has been released
var canShoot: bool = true

func _process(delta: float) -> void:
	# Reset velocity each frame
	velocityBetter = Vector2.ZERO
#Handle forward and backward movement
	if Input.is_action_pressed("move_forward"):
		velocityBetter.x += 1  # Moving forward
	if Input.is_action_pressed("move_backwards"):
		velocityBetter.x -= 1  # Moving backward

	# Handle rotation
	if Input.is_action_pressed("rotate_left"):
		rotation -= rotationSpeed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation += rotationSpeed * delta

	# Shoot a bullet if the shoot button is pressed and we are allowed to shoot
	if Input.is_action_just_pressed("shootBullet") and canShoot:
		shoot()
		canShoot = false  # Prevent shooting again until the button is released

	# Reset the shooting flag when the shoot button is released
	if Input.is_action_just_released("shootBullet"):
		canShoot = true

	# Apply rotation to the velocity (but only after handling rotation)
	if velocityBetter.length() > 0:
		velocityBetter = velocityBetter.rotated(rotation) * moveSpeed

	# Move the tank using move_and_collide
	move_and_collide(velocityBetter * delta)

func shoot() -> void:
	#instance the bullet scene
	var bullet = bullet_scene.instantiate()
	
	# Set the bullet's position to the tank's position, slightly in front of the tank
	bullet.global_position = global_position + Vector2.RIGHT.rotated(rotation) * 30 # Adjust 30 for how far ahead the bullet spawns
	
	# Set the bullet's initial velocity in the direction of the tank's rotation
	bullet.rotation = rotation
	
	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
