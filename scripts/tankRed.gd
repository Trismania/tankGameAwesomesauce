extends CharacterBody2D

# Speed and rotation speed
@export var moveSpeed: float = 200.0
@export var rotationSpeed: float = 3.0
@export var bullet_scene: PackedScene  # Drag and drop the Bullet scene here in the inspector

# Movement direction vector
var velocityBetter: Vector2 = Vector2.ZERO

# Shooting cooldown
var shootCooldown: float = 1.0  # Cooldown time between shots
var shootTimer: float = 0.0

func _process(delta: float) -> void:
	# Reset velocity each frame
	velocityBetter = Vector2.ZERO

	# Handle forward and backward movement
	if Input.is_action_pressed("move_forward"):
		velocityBetter.y -= 1  # Moving forward
	if Input.is_action_pressed("move_backwards"):
		velocityBetter.y += 1  # Moving backward

	# Handle rotation
	if Input.is_action_pressed("rotate_left"):
		rotation -= rotationSpeed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation += rotationSpeed * delta
	
	#Shoot a bullet
	if Input.is_action_pressed("shootBullet"):
		shoot()
	
	
	# Apply rotation to the velocity (but only after handling rotation)
	if velocityBetter.length() > 0:
		velocityBetter = velocityBetter.rotated(rotation) * moveSpeed

	# Move the tank using move_and_collide
	move_and_collide(velocityBetter * delta)

	# Shooting cooldown timer
	shootTimer -= delta
	if shootTimer <= 0.0 and Input.is_action_pressed("shootBullet"):  # Assuming "shoot" is mapped
		shoot()
		shootTimer = shootCooldown  # Reset the cooldown after shooting

func shoot() -> void:
	# Instance the bullet scene
	var bullet = bullet_scene.instantiate()

	# Set bullet position at the front of the tank (barrel)
	bullet.position = global_position + Vector2.UP.rotated(rotation) * 20  # Adjust the offset based on the tank size

	# Set the bullet's rotation to match the tank's current rotation
	bullet.rotation = rotation

	# Add the bullet to the parent scene (game world)
	get_parent().add_child(bullet)
