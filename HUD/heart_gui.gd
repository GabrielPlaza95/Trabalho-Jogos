extends Panel

@onready var sprite = $Sprite2D
var heart_full = preload("res://HUD/hud_heartFull.png")
var heart_empty = preload("res://HUD/hud_heartEmpty.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update(full: bool):
	if full: sprite.texture = heart_full
	else: sprite.texture = heart_empty
