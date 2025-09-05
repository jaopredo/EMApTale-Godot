extends Control

@onready var options = [
	get_node("HBoxContainer/Yes"),
	get_node("HBoxContainer/No")
]

@onready var actual_option = 0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func change_option(opt):
	options[actual_option].icon = null
	$SqueakSound.play()
	actual_option = opt

func _process(delta: float) -> void:
	options[actual_option].icon = load("res://Sprites/Player/hearts/heart.png")
	
	var go_to = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
	if go_to != 0:
		change_option((int(actual_option + go_to)) % options.size())
	
	if Input.is_action_just_pressed("accept"):
		options[actual_option].pressed.emit()
		$SelectSound.play()


func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start/PlayerName.tscn")


func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start/StartScreen.tscn")
