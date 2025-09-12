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

## Dano que o player dá em um boss
@export var damage = 10

## Inventário do player
@export var inventory = []

func add_item(item):
	inventory.append(Item.new(item.item_id))
