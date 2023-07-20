extends Area2D

@export var damage_points : int = 1
@export var speed : float = 300

var direction = Vector2(-1, 0)

func _physics_process(delta):
	position += speed * direction * delta

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.damage(damage_points)
