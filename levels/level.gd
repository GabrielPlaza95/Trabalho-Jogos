extends Node2D

func _on_protagonist_shoot(bullet, bullet_direction, bullet_position):
	var spawned_bullet = bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.position = bullet_position
	spawned_bullet.direction = bullet_direction
