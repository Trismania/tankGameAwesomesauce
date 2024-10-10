extends Node

# Variables to store player scores
var player1_score: int = 0
var player2_score: int = 0

func _process(delta: float) -> void:
	if player1_score >= 5:
		# Change to a scene with a specific path
		get_tree().change_scene_to_file("res://scenes/tank_red_win.tscn")
	elif player2_score >= 5:
		get_tree().change_scene_to_file("res://scenes/tank_green_wins.tscn")
