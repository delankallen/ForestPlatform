extends Control

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_instructions():
	show_message("Fell in a hole!")
	yield($MessageTimer, "timeout")
	
	yield(get_tree().create_timer(1), "timeout")


func _on_MessageTimer_timeout():
	$Message.hide() # Replace with function body.


func _on_StartButton_pressed():
	$StartButton.hide()
	$Title.hide()
	$Message.hide()
	emit_signal("start_game")
