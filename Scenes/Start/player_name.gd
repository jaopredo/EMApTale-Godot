extends Control

@export var MAX_CHARACTERS = 20;

func _ready() -> void:
	$PlayerNameInput.grab_focus()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("accept") and $PlayerNameInput.text.length() != 0:
		get_tree().change_scene_to_file("res://Scenes/Start/Cutscene/StarterCutscene.tscn")
