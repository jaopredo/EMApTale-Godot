extends Control

@onready var options = [
	get_node("VBoxContainer/StartButton"),
	get_node("VBoxContainer/LoadButton"),
	get_node("VBoxContainer/OptionsButton"),
	get_node("VBoxContainer/ExitButton"),
]

@onready var actual_option = 0

func change_option(opt):
	options[actual_option].icon = null
	$SqueakSound.play()
	actual_option = opt

func _process(delta: float) -> void:
	options[actual_option].icon = load("res://Sprites/Player/hearts/heart.png")
	
	var go_to = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
	if go_to != 0:
		change_option((int(actual_option + go_to)) % options.size())
	
	if Input.is_action_just_pressed("accept"):
		options[actual_option].pressed.emit()
		$SelectSound.play()


func _on_start_button_pressed() -> void:
	print("START")

func _on_start_button_mouse_entered() -> void:
	change_option(0)


func _on_load_button_pressed() -> void:
	print("LOAD")
	
func _on_load_button_mouse_entered() -> void:
	change_option(1)


func _on_options_button_pressed() -> void:
	print("OPTIONS")

func _on_options_button_mouse_entered() -> void:
	change_option(2)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_exit_button_mouse_entered() -> void:
	change_option(3)
