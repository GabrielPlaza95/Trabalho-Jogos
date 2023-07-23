extends Panel

@onready var sprite = $Sprite2D
var heart_full = preload("res://HUD/hud_heartFull.png")
var heart_empty = preload("res://HUD/hud_heartEmpty.png")

func update(full: bool):
	if full: sprite.texture = heart_full
	else: sprite.texture = heart_empty
