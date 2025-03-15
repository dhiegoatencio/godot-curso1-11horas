extends StaticBody2D
class_name ItemContainerClass

signal open(posi, direction)

# se tentar rodar an
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false

func hit(_damage):
	open.emit(position, current_direction)
