extends Area2D

var Player = preload("res://Objects/Frisk/frisk.gd")


func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):
		var tween = create_tween()
		tween.tween_property($Sprite2D, "modulate:a", .5, .5)


func _on_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Player):
		var tween = create_tween()
		tween.tween_property($Sprite2D, "modulate:a", 0, .5)
