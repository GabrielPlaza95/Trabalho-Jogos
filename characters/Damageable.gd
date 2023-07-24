extends Node

class_name Damageable

@export var health_points : int = 1

signal damaged
signal healed
signal dead

func damage(damage_points: int):
	health_points -= damage_points
	
	damaged.emit()

	if health_points <= 0:
		dead.emit()

func heal(healing_points: int):
	if (health_points < 3):
		health_points += healing_points
	healed.emit()

