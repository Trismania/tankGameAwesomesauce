extends RigidBody2D

@export var speed: float = 500.0
var bounce_count: int = 0
var max_bounces: int = 3

func _ready() -> void:
	# Apply initial impulse to the pellet when it's created
	var direction: Vector2 = Vector2.UP.rotated(rotation)  # Use the pellet's current rotation
	apply_impulse(Vector2.ZERO, direction * speed)  # Apply force to the pellet in the direction of the tank's barrel

# This function handles the bouncing and despawning logic
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Check if the pellet has collided with something
	if state.get_contact_count() > 0:
		bounce_count += 1  # Increment bounce count when a collision occurs
		if bounce_count >= max_bounces:
			queue_free()  # Despawn the pellet after 3 bounces

# This function handles what happens when the pellet hits something
func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:  # Check if the pellet hits a tank
		body.gameWon(body.name)  # Call the gameWon method with the tank's name
		queue_free()  # Despawn the pellet after hitting a tank
