extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Protagonist

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.damageable.health_points)
	player.healthChanged.connect(heartsContainer.updateHearts)


func _on_protagonist_shoot(Bullet, bullet_direction, bullet_position):
	var spawned_bullet = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.position = bullet_position
	spawned_bullet.direction = bullet_direction

func _on_guitar_win():
	print("caralho")
	get_tree().change_scene_to_file("res://levels/StartScreen.tscn")
