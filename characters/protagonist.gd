extends CharacterBody2D

@export var speed : float = 75.0
@export var jump_velocity : float = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_direction : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2(-1, 0)

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Sprite2D

signal shoot(bullet, direction, position)

var Bullet = preload("res://characters/bullet.tscn")

func _process(_delta):
	if input_direction.x != 0:
		_animation_player.play("walk")
	else:
		_animation_player.stop()
		
	if input_direction.x > 0:
		direction.x = 1
		_sprite.flip_h = true
	elif input_direction.x < 0:
		direction.x = -1
		_sprite.flip_h = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Shooting
	if Input.is_action_just_pressed("shoot"):
		shoot.emit(Bullet, direction, position + direction * 14)

	# Handle Jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Basic Movement
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction.x != 0:
		velocity.x = input_direction.x * speed
	else:
		velocity.x = 0
		

	move_and_slide()

func update_animation():
	pass
