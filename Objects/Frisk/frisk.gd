extends CharacterBody2D

signal direction_changed(direction: String)

@onready var SPEED = 100
@onready var previous_direction = "walking_right"


func get_actual_direction():
	if velocity.x > 0:
		return "walking_right"
	elif velocity.x < 0:
		return "walking_left"
	elif velocity.y > 0:
		return "walking_down"
	elif velocity.y < 0:
		return "walking_up"
	
	if velocity.length() == 0:
		if previous_direction == "walking_up":
			return "idle_up"
		elif previous_direction == "walking_right":
			return "idle_right"
		elif previous_direction == "walking_left":
			return "idle_left"
		elif previous_direction == "walking_down":
			return "idle_down"


func _physics_process(delta: float) -> void:
	var y_direction = Input.get_axis("up", "down")
	var x_direction = Input.get_axis("left", "right")
	
	velocity = Vector2(
		x_direction,
		y_direction
	).normalized() * SPEED
	
	var actual_direction = get_actual_direction()
	if actual_direction != previous_direction:
		direction_changed.emit(actual_direction)
	previous_direction = actual_direction
	
	move_and_slide()


func _on_direction_changed(direction: String) -> void:
	print(direction)
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play(direction)
