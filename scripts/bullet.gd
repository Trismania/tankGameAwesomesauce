extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var tankRed: CharacterBody2D = get_parent().get_node("tankRed")
@onready var tankGreen: CharacterBody2D = get_parent().get_node("tankGreen")




@export var speed: float = 100.0 # bullet speed
var direction: Vector2 = Vector2.ZERO  # Direction the bullet should move in
var bounce_count: int = 0 # To track how many times the bullet has bounced


# This function is called by the tank to set the bullet's direction
@warning_ignore("unused_parameter")
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

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	# Normalize the velocity to keep a constant speed
	if linear_velocity.length() != speed:
		linear_velocity = linear_velocity.normalized() * 200

# Bullet gets deleted when timer runs out
func _on_timer_timeout() -> void:
	queue_free()





func _on_area_2d_body_entered(body: Node2D) -> void:
	# Check if the body is of type CharacterBody2D
	if body is CharacterBody2D:
		# Check if the body is the specific instance of the red tank
		if body.name == "tankRed":  # Assuming the node's name is 'tankRed'
			print("Rød tank blev ramt")
			Global.player2_score += 1
		elif body.name == "tankGreen":
			print("Grøn tank blev ramt")
			Global.player1_score += 1

		# Safely reload the current scene after the physics step is complete
		call_deferred("_reload_scene")

# Function to reload the current scene safely
func _reload_scene() -> void:
	get_tree().reload_current_scene()
