extends Area2D

@export var healing_points : int = 1

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.heal(healing_points)
	queue_free()
