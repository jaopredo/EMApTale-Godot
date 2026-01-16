extends Control

@onready var options = [
	$Options/OptionsBoxContainer/Item,
	$Options/OptionsBoxContainer/Stat,
]
## Opção atual dentre as opções padrões (Itens, Stat, Cell)
@onready var actual_option = 0
## Indica se o retângulo após selecionar está aparecendo
@onready var is_main_box_apprearing = false

## Variável que indica qual o item que eu estou selecionando caso meu inventário
## esteja aberto
@onready var actual_item_option = 0
## Variável que indica a ação que eu vou tomar após selecionar um item em específico
@onready var actual_item_action = 0
## Variável que indica se tem um item sendo selecionado
@onready var item_selected = false
## Variável para controle, indica quantos itens eu tenho no meu inventário
@onready var inventory_size = GlobalPlayerManager.inventory.size()

## Textura do coração para os botões
@onready var HEART_TEXTURE = preload("res://Sprites/Player/hearts/heart.png")
## Lista dos botões dos itens
@onready var ITEMS_BUTTONS = []
## Lista dos botões dos itens
@onready var ITEMS_ACTIONS = [
	$Main/InventoryMain/Options/USE,
	$Main/InventoryMain/Options/INFO,
	$Main/InventoryMain/Options/DROP,
]
## Tema dos botões para estilização
@onready var BUTTON_THEME = preload("res://Themes/InventoryButton.tres")


func _ready() -> void:
	# Checo o inventário do player e adiciono os botões dos itens
	for item in GlobalPlayerManager.inventory:
		var item_button = Button.new()
		item_button.text = item.item_name
		item_button.theme = BUTTON_THEME
		item_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		$Main/InventoryMain/Items.add_child(item_button)
		ITEMS_BUTTONS.append(item_button)


## Função responsável por deixar visível ou não minha main box
func turn_main_box(value=null):
	# Se eu não passar nenhum valor
	if value == null:
		# Eu vou colocar para o valor contrário do que estava antes
		$Main.visible = !$Main.visible
		is_main_box_apprearing = !is_main_box_apprearing
		options[actual_option].icon = null
	# Se não
	else:
		# Eu coloco para o valor que eu passei
		$Main.visible = value
		is_main_box_apprearing = value
		# Se eu passei FALSE, eu vou colocar a textura de coração
		# na última opção q selecionei
		if not value:
			options[actual_option].icon = HEART_TEXTURE
		# Se não, eu vou deixar sem ícone
		else:
			options[actual_option].icon = null
	
	# Aqui é para ocultar todos os textos q podem aparecer no main box
	if not $Main.visible:
		$Main/InventoryMain.visible = false
		$Main/StatsMain.visible = false


func _process(delta: float) -> void:
	# Colocando os textos nas opções
	$PlayerInformations/HP2.text = "%d/%d" % [GlobalPlayerManager.current_health, GlobalPlayerManager.total_health]
	$PlayerInformations/Level2.text = "%d" % GlobalPlayerManager.current_level
	$PlayerInformations/Money2.text = "%0.2f" % GlobalPlayerManager.money
	
	$Main/StatsMain/LevelSlot.text = "%d" % GlobalPlayerManager.current_level
	$Main/StatsMain/Attack.text = "AT %d" % GlobalPlayerManager.damage
	$Main/StatsMain/Defense.text = "DF %d" % GlobalPlayerManager.defense
	$Main/StatsMain/Money.text = "R$%0.2f" % GlobalPlayerManager.money
	$Main/StatsMain/Experience.text = "EXP %d" % GlobalPlayerManager.current_xp
	$Main/StatsMain/ExperienceForNextLevel.text = "NEXT %d" % GlobalPlayerManager.total_xp
	$Main/StatsMain/HPSlot.text = "%d/%d" % [GlobalPlayerManager.current_health, GlobalPlayerManager.total_health]
	
	# Mexer o cursor pelas opções do inventário
	if not is_main_box_apprearing:
		var go_to = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
		if go_to != 0:
			options[actual_option].icon = null
			actual_option = int(actual_option + go_to) % options.size()
			options[actual_option].icon = HEART_TEXTURE
			$Squeak.play()
	
		# Selecionando uma opção
		if Input.is_action_just_pressed("accept"):
			$Select.play()
			options[actual_option].pressed.emit()
	else:
		# Voltando para as opções
		if Input.is_action_just_pressed("cancel") and not item_selected:
			turn_main_box(false)
		
		if $Main/InventoryMain.visible:
			if not item_selected:
				if GlobalPlayerManager.inventory.size() > 0:
					var go_to = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
					if go_to != 0:
						ITEMS_BUTTONS[actual_item_option].icon = null
						actual_item_option = int(actual_item_option + go_to) % inventory_size
						ITEMS_BUTTONS[actual_item_option].icon = HEART_TEXTURE
						$Squeak.play()
					if Input.is_action_just_pressed("accept"):
						$Select.play()
						item_selected = true
						ITEMS_BUTTONS[actual_item_option].icon = null
						ITEMS_ACTIONS[actual_item_action].icon = HEART_TEXTURE
			else:
				var go_to = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
				if go_to != 0:
					ITEMS_ACTIONS[actual_item_action].icon = null
					actual_item_action = int(actual_item_action + go_to) % ITEMS_ACTIONS.size()
					ITEMS_ACTIONS[actual_item_action].icon = HEART_TEXTURE
					$Squeak.play()
				
				if Input.is_action_just_pressed("accept"):
					ITEMS_ACTIONS[actual_item_action].pressed.emit()
				
				if Input.is_action_just_pressed("cancel"):
					ITEMS_ACTIONS[actual_item_action].icon = null
					ITEMS_BUTTONS[actual_item_option].icon = HEART_TEXTURE
					item_selected = false


func _on_item_pressed() -> void:
	turn_main_box()
	$Main/InventoryMain.visible = true
	if inventory_size > 0:
		ITEMS_BUTTONS[actual_item_option].icon = HEART_TEXTURE


func _on_stat_pressed() -> void:
	turn_main_box()
	$Main/StatsMain.visible = true


func _on_drop_pressed() -> void:
	GlobalPlayerManager.Frisk.drop_item.emit(actual_item_option)
	queue_free()
	GlobalPlayerManager.Frisk.can_move = true


func _on_use_pressed() -> void:
	print("Usou o item!")
