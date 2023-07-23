extends CharacterBody2D

@export var speed : float = 75.0
@export var jump_velocity : float = -250.0
@export var maxHealth = 3 # tem que sincronizar com o health_points
@onready var damageable = $Damageable
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_direction : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2(-1, 0)
var can_shoot : bool = true

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Sprite2D
@onready var _strum_audio = $StrumSound
@onready var _glide_audio = $GlideSound
@onready var _strum_timer = $StrumRecoil
@onready var _strum_sound_timer = $StrumSoundLoop

signal shoot(bullet, direction, position)
signal healthChanged

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
		if can_shoot:
			shoot.emit(Bullet, direction, position + direction * 14)
			_strum_timer.start()
			can_shoot = false
		
		if not _strum_audio.playing:
			_strum_audio.play()
			
		_strum_sound_timer.start()

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

func _on_strum_recoil_timeout():
	can_shoot = true

func _on_strum_sound_loop_timeout():
	_strum_audio.stop()

func _on_damage():
	_sprite.modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	_sprite.modulate = Color.WHITE
	healthChanged.emit(damageable.health_points)
	_glide_audio.play()

func _on_death():
	_sprite.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	_glide_audio.play()
	get_tree().change_scene_to_file("res://levels/StartScreen.tscn")
	free()
