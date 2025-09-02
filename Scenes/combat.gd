extends Node2D

@onready var BattleContainer = get_node("BattleContainer")
@onready var Menu = get_node("Interface/Menu")
@onready var Player = get_node("Player")

@onready var ACTUAL_TURN = "player"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace"):
		change_turn()
	
	if ACTUAL_TURN == "player":
		var tween = get_tree().create_tween()
		tween.tween_property(BattleContainer, "scale", BattleContainer.SCALE_ON_PLAYER_TURN, .7)
		
		if not Menu.is_inside_tree():
			$Interface.add_child(Menu)
			
		if Player and Player.is_inside_tree():
			var temp_player = Player
			Player = Player.duplicate()
			temp_player.queue_free()
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(BattleContainer, "scale", BattleContainer.SCALE_ON_BOSS_TURN, .7)
		
		if not Player.is_inside_tree():
			Player.position = $BattleContainer.position/2
			get_tree().root.add_child(Player)
		
		if Menu and Menu.is_inside_tree():
			var temp_menu = Menu
			Menu = Menu.duplicate()
			temp_menu.queue_free()

func change_turn():
	if ACTUAL_TURN == "player":
		ACTUAL_TURN = "boss"
	else:
		ACTUAL_TURN = "player"
