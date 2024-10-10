extends RigidBody2D

@onready var timer: Timer = $Timer


@export var speed: float = 100.0 # bullet speed
var direction: Vector2 = Vector2.ZERO  # Direction the bullet should move in
var bounce_count: int = 0 # To track how many times the bullet has bounced


# This function is called by the tank to set the bullet's direction
func set_direction_and_shooter(dir: Vector2, shooter) -> void:
	direction = dir.normalized()  # Ensure direction is normalized
	linear_velocity = direction * speed * 200  # Set initial velocity of the bullet

# Called when the node is added to the scene
func _ready() -> void:
	timer.start()
	# Disable gravity for the bullet
	gravity_scale = 0.0
	
	# Disable damping to prevent the bullet from slowing down
	linear_damp = 0.0
	angular_damp = 0.0

func _physics_process(delta: float) -> void:
	# Normalize the velocity to keep a constant speed
	if linear_velocity.length() != speed:
		linear_velocity = linear_velocity.normalized() * 200

# Bullet gets deleted when timer runs out
func _on_timer_timeout() -> void:
	queue_free()
