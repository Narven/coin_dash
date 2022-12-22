extends CanvasLayer

signal start_game

# PUBLIC

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

func update_timer(value):
	$MarginContainer/TimeLabel.text = str(value)

func show_message(text):
	$VBoxContainer/MessageLabel.text = str(text)
	$VBoxContainer/MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$VBoxContainer/StartButton.show()
	$VBoxContainer/MessageLabel.text = "Coin Dash!"
	$VBoxContainer/MessageLabel.show()

# EVENTS

func _on_MessageTimer_timeout():
	$VBoxContainer/MessageLabel.hide()

func _on_StartButton_pressed():
	$VBoxContainer/StartButton.hide()
	$VBoxContainer/MessageLabel.hide()
	emit_signal("start_game")
