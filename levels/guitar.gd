extends Area2D

signal win


func _on_body_entered(body):
	if body.name == "protagonist":
		win.emit()
		print("you win!!") #  change scene to you win screen
