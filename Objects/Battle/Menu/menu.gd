extends HBoxContainer

@onready var OPTIONS = [
	get_node("FightButton"),
	get_node("ActButton"),
	get_node("ItemButton"),
	get_node("MercyButton")
]

@onready var selected_option = 0;

func _process(delta: float) -> void:
	# Forço o meu option a ficar com estado de foco
	OPTIONS[selected_option].grab_focus()
	# Checo para qual direçao o meu player apertou
	var go_to = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
	# Movo o cursor
	selected_option = ( int(selected_option + go_to) ) % OPTIONS.size()
	
	if go_to != 0:
		$SqueakSound.play()
