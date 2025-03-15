extends Node

signal health_change
signal laser_change
signal grenade_change

var laser_amount: int = 10:
	set(value):
		laser_amount = value
		laser_change.emit()

var grenade_amount: int = 5:
	set(value):
		grenade_amount = value
		grenade_change.emit()

var health: int = 100:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			health = value
		health_change.emit()

var player_pos: Vector2
