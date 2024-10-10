extends Area2D

@export var bullet_speed: float = 400.0
var velocity: Vector2 = Vector2.ZERO
var bounce_count: int = 0
@export var max_bounces: int = 3

# Called when the bullet is first added to the scene


# Set bullet's velocity and shooter reference
func set_direction_and_shooter(dir: Vector2, shooter_ref: Node) -> void:
	velocity = dir.normalized() * bullet_speed

# Move the bullet using velocity in _physics_process
func _physics_process(delta: float) -> void:
	position += velocity * delta




# Handle bouncing logic
func handle_bounce1() -> void:
	velocity.x = -velocity.x  # Bounce on x-axis

	# Track bounce count and destroy bullet after max bounces
	bounce_count += 1
	if bounce_count >= max_bounces:
		queue_free()  # Destroy the bullet

func handle_bounce2() -> void:
	velocity.y = -velocity.y  # Bounce on x-axis

	# Track bounce count and destroy bullet after max bounces
	bounce_count += 1
	if bounce_count >= max_bounces:
		queue_free()  # Destroy the bullet
