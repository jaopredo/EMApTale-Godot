extends Node2D

# Sinal responsável por indicar quando mudou de turno entre player e inimigo
signal change_turn

@onready var BattleContainer = get_node("BattleContainer")
@onready var Menu = get_node("Interface/Menu")
@onready var Player = preload("res://Objects/Player/Player.tscn")

@onready var ACTUAL_TURN: GlobalCombat.Turn = GlobalCombat.Turn.player

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace"):
		change_turn.emit()


## Função que adiciona o coração (player) na tela para o combate
func add_player_on_screen():
	var player = Player.instantiate()
	player.position = $BattleContainer.position/2
	add_child(player)

## Função que remove o coração (player) na tela para o combate
func remove_player_from_screen():
	var player = get_node('Player')
	player.queue_free()


## Função que adiciona o menu na tela
func add_menu_on_screen():
	if not Menu.is_inside_tree():
		$Interface.add_child(Menu)

## Função que remove o menu da tela
func remove_menu_from_screen():
	if Menu and Menu.is_inside_tree():
		var temp_menu = Menu
		Menu = Menu.duplicate()
		temp_menu.queue_free()


# Quando eu mudo o turno
func _on_change_turn() -> void:
	# Se o turno atual for do player
	if ACTUAL_TURN == GlobalCombat.Turn.player:
		ACTUAL_TURN = GlobalCombat.Turn.boss  # Mudo para o turno do Boss
		
		add_player_on_screen()
		
		remove_menu_from_screen()
		
		# Modificando a escala do container
		BattleContainer.rescale(ACTUAL_TURN)
	else:  # Se não
		ACTUAL_TURN = GlobalCombat.Turn.player  # Mudo para o turno do player
		
		remove_player_from_screen()
		
		add_menu_on_screen()
		
		# Modificando a escala do container
		BattleContainer.rescale(ACTUAL_TURN)
