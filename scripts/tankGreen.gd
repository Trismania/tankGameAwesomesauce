extends CharacterBody2D

#Speed and rotation speed
@export var moveSpeed: float = 200.0
@export var rotationSpeed: float = 3.0
@export var bullet_scene: PackedScene  # Drag and drop the Bullet scene here in the inspector

#Movement direction vector
var velocityBetter2: Vector2 = Vector2.ZERO

#Flag to track whether the shoot button has been released
var canShoot: bool = true

func _process(delta: float) -> void:
	# Reset velocity each frame
	velocityBetter2 = Vector2.ZERO
#Handle forward and backward movement
	if Input.is_action_pressed("move_forward2"):
		velocityBetter2.x += 1  # Moving forward
	if Input.is_action_pressed("move_backwards2"):
		velocityBetter2.x -= 1  # Moving backward

	# Handle rotation
	if Input.is_action_pressed("rotate_left2"):
		rotation -= rotationSpeed * delta
	if Input.is_action_pressed("rotate_right2"):
		rotation += rotationSpeed * delta

	# Shoot a bullet if the shoot button is pressed and we are allowed to shoot
	if Input.is_action_just_pressed("shootBullet2") and canShoot:
		shoot()
		canShoot = false  # Prevent shooting again until the button is released

	# Reset the shooting flag when the shoot button is released
	if Input.is_action_just_released("shootBullet2"):
		canShoot = true

	# Apply rotation to the velocity (but only after handling rotation)
	if velocityBetter2.length() > 0:
		velocityBetter2 = velocityBetter2.rotated(rotation) * moveSpeed

	# Move the tank using move_and_collide
	move_and_collide(velocityBetter2 * delta)

func shoot() -> void:
	# Instance the bullet scene
	var bullet = bullet_scene.instantiate()
	
	# Set bullet position at the front of the tank (barrel)
	bullet.position = global_position + Vector2.RIGHT.rotated(rotation) * 20  # Adjust the offset based on the tank size
	
	# Set the bullet's rotation to match the tank's current rotation
	bullet.rotation = rotation
	
	# Set the bullet's velocity so it moves in the direction the tank is facing
	var bullet_direction = Vector2.RIGHT.rotated(rotation)
	
	# Call the method on the bullet to set its direction and shooter
	bullet.set_direction_and_shooter(bullet_direction, self)
	
	# Add the bullet to the parent scene (game world)
	get_parent().add_child(bullet)
