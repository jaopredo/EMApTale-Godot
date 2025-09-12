extends Node2D

signal change_turn

@onready var BattleContainer = get_node("BattleContainer")
@onready var Menu = get_node("Interface/Menu")
@onready var Player = preload("res://Objects/Player/Player.tscn")

@onready var ACTUAL_TURN = "player"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace"):
		change_turn.emit()
	
	if ACTUAL_TURN == "player":
		var tween = get_tree().create_tween()
		tween.tween_property(BattleContainer, "scale", BattleContainer.SCALE_ON_PLAYER_TURN, .7)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(BattleContainer, "scale", BattleContainer.SCALE_ON_BOSS_TURN, .7)


func _on_change_turn() -> void:
	if ACTUAL_TURN == "player":
		ACTUAL_TURN = "boss"
		
		var player = Player.instantiate()
		player.position = $BattleContainer.position/2
		add_child(player)
		
		if Menu and Menu.is_inside_tree():
			var temp_menu = Menu
			Menu = Menu.duplicate()
			temp_menu.queue_free()
	else:
		ACTUAL_TURN = "player"
		
		if not Menu.is_inside_tree():
			$Interface.add_child(Menu)
			
		var player = get_node('Player')
		player.queue_free()
