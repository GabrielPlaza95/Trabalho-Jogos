extends CharacterBody2D

@export var speed : float = 20.0
@export var damage_points : int = 1

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Sprite2D

var direction : Vector2 = Vector2(-1, 0)

func _process(_delta):
	if direction.x != 0:
		_animation_player.play("walk")
	else:
		_animation_player.stop()
		
	if direction.x > 0:
		direction.x = 1
		_sprite.flip_h = true
	elif direction.x < 0:
		direction.x = -1
		_sprite.flip_h = false

func _physics_process(_delta):
	velocity.x = direction.x * speed
	move_and_slide()

# Enemy hit player
func _on_attack_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.damage(damage_points)

# Move back and forth
func _on_walk_cycle_timeout():
	direction.x *= -1
