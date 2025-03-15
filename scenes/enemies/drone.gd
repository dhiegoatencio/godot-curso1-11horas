extends CharacterBody2D

func _process(_delta: float) -> void:
	# position = Vector2(position.x + (200 * delta), position.y)
	var direction = Vector2.RIGHT
	velocity = direction * 300
	move_and_slide()

func hit():
	print('hit')
