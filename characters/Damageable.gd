extends Node

class_name Damageable

@export var health_points : int = 1

func damage(damage_points: int):
	health_points -= damage_points

	if health_points <= 0:
		get_parent().queue_free()

