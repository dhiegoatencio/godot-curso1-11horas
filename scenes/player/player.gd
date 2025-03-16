extends CharacterBody2D
var ShaderColorProgress = load("res://materials/shader_color_progress.gd")  # Carrega o script sem instanciar

signal laser(pos: Vector2, direction: Vector2)
signal grenade(pos: Vector2, direction: Vector2)
signal death

var can_laser: bool = true
var can_grenade: bool = true

@export var joystick_left : VirtualJoystick
@export var joystick_right : VirtualJoystick
@export var max_speed: int = 500
var speed: int = max_speed

# touch
# Inicialização da posição do personagem



func _process(_delta: float) -> void:
	var direction

	if joystick_left and joystick_left.is_pressed:
		direction = joystick_left.output
	else:
		direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * speed

	move_and_slide()
	Globals.player_pos = global_position # store position of the playeras\

	# rotate playear
	# Rotate the gun to aim towards the second touch input (aiming)
	# Rotation:
	if joystick_right and joystick_right.is_pressed:
		rotation = joystick_right.output.angle()
	else:
		look_at(get_global_mouse_position())



	# laser shootin input
	if Input.is_action_just_pressed("primary action") or joystick_right.is_pressed:
		shoot()

	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var marker: Marker2D = $LaserStartPositions.get_children()[0]
		can_grenade = false
		var player_direction: Vector2 = (get_global_mouse_position() - position).normalized()
		grenade.emit(marker.global_position, player_direction)
		$GrenadeReloadTimer.start()

func shoot():
	if can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser_marker: Marker2D = laser_markers[randi() % laser_markers.size()] # usar o randi e o MOD do maior número que pode ser selecionado
		can_laser = false
		#var player_direction: Vector2 = (get_global_mouse_position() - position).normalized()
		var player_direction = (Vector2(cos(rotation), sin(rotation))).normalized()
		laser.emit(selected_laser_marker.global_position, player_direction)
		$LaserTimer.start()

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true

func hit(damage):
	Globals.health -= damage
	if Globals.health > 0: ShaderColorProgress.hit($PlayerImage, get_tree())
	else:
		await ShaderColorProgress.lastHit($PlayerImage, get_tree())
		death.emit()
