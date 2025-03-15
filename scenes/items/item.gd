extends Area2D

var rotation_speed: int = 3
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options[randi() % len(available_options)]
# var type = 'laser'

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready() -> void:
	var color
	match type:
		'laser':	color = Color(.1,.2,.6)
		'grenade':	color = Color(.1,.7,.1)
		'health':	color = Color(.6,.1,.2)
	$Sprite2D.modulate = color
	
	# tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	# efeito de ir crescendo (como se estivesse saindo de dentro do item)
	tween.tween_property(self, 'scale', Vector2(1,1), 0.3).from(Vector2(0,0))

func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	match type:
		'health': Globals.health += 40
		'grenade': Globals.grenade_amount += 2
		'laser': Globals.laser_amount += 5
	queue_free()
