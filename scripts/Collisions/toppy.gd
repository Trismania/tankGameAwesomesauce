extends Area2D

@onready var bullet: Area2D = $".."




func _on_body_entered(body: Node2D) -> void:
	bullet.handle_bounce2()
