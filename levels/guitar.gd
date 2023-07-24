extends Area2D

signal win

@onready var chord = $AudioStreamPlayer

func _on_body_entered(_body):
	chord.play()
	await get_tree().create_timer(2.5).timeout
	win.emit()
