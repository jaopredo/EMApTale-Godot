extends Node

## Classe do item
@onready var Item = preload("res://Globals/Item.gd")


## Vida atual do player
@export var current_health: float = 20
## Vida máxima do player
@export var total_health: float = 20

## Nível atual do player
@export var current_level: int = 1

## XP do player
@export var current_xp: int = 0
## Máximo de XP para o próximo nível
@export var total_xp: int = 100

## Dinheiro do Player
@export var money: float = 0

## Dano que o player dá em um boss
@export var damage = 10
## Quanto de defesa o player possui
@export var defense = 10

## Arma equipada
@export var EquipedWeapon = null
## Armadura equipada
@export var EquipedArmor = null

## Frisk Object
@export var Frisk = null

## Inventário do player
@export var inventory = []

func add_item(item):
	inventory.append(Item.new(item.item_id))

func remove_item(id: int):
	inventory.pop_at(id)

func take_hit(hit: float):
	current_health -= hit

func heal(amount: float):
	current_health += amount
