extends RigidBody2D

@export var speed: float = 300.0 # bullet speed
var direction: Vector2 = Vector2.ZERO  # Direction the bullet should move in
var bounce_count: int = 0 # To track how many times the bullet has bounced

# This function is called by the tank to set the bullet's direction
func set_direction_and_shooter(dir: Vector2, shooter) -> void:
	direction = dir.normalized()  # Ensure direction is normalized
	linear_velocity = direction * speed  # Set initial velocity of the bullet

# Called when the node is added to the scene
func _ready() -> void:
	# Disable gravity for the bullet
	gravity_scale = 0.0
	
	# Disable damping to prevent the bullet from slowing down
	linear_damp = 0.0
	angular_damp = 0.0

func _physics_process(delta: float) -> void:
	# Normalize the velocity to keep a constant speed
	if linear_velocity.length() != speed:
		linear_velocity = linear_velocity.normalized() 

# Function called when the bullet collides with something
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Check for collisions and bounce off walls
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider(i)
		if collider:
			bounce_count += 1 # Increment bounce count each time it collides
			
			# If it has collided 3 times, queue it for deletion
			if bounce_count >= 3:
				queue_free()
