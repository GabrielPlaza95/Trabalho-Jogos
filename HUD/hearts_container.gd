extends HBoxContainer

@onready var HeartGuiClass = preload("res://HUD/heart_gui.tscn")

func setMaxHearts(max_hearts: int):
	for i in range(max_hearts):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
		
		
func updateHearts(currentHealth: int):
	var hearts = get_children()
	for i in range(currentHealth):
		hearts[i].update(true)
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
