extends Node

func new_game():
	$LostKing.start($StartPosition.position)

func _ready():
	randomize()
	new_game()
