extends CharacterBody2D

@export var speed : float = 100.0
@export var jump_velocity : float = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Sprite2D

func _process(_delta):
	if direction.x != 0:
		_animation_player.play("walk")
	else:
		_animation_player.stop()
		
	if direction.x > 0:
		_sprite.flip_h = true
	elif direction.x < 0:
		_sprite.flip_h = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		

	move_and_slide()

func update_animation():
	pass
