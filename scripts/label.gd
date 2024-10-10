extends Label

	
func _process(_delta: float) -> void:
	text = str(Global.player1_score) + " VS " + str(Global.player2_score)
