extends CharacterBody2D
class_name ScoutClass

var ShaderColorProgress = load("res://materials/shader_color_progress.gd")  # Carrega o script sem instanciar

signal laser(pos, direction)

var player_nearby: bool = false
var laser_cooldown_timer = 1
var right_gun_use: bool = true # alterna entre 0 e 1

var health: int = 30

func _process(_delta: float) -> void:
	if player_nearby and health > 0:
		look_at(Globals.player_pos)	
		if $LaserCooldownTimer.is_stopped(): # ao inves de usar variavel, uso o método
			var marker: Marker2D = $LaserSpawsPositions.get_child(right_gun_use) # true = 1 ; false = 0
			right_gun_use = not right_gun_use # alterna a arma utilizada
			var pos: Vector2 = marker.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			$LaserCooldownTimer.start(laser_cooldown_timer)
			laser.emit(pos, direction)

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func hit(damage):
	health -= damage
	if health > 0: ShaderColorProgress.hit($Sprite2D, get_tree())
	else:
		await ShaderColorProgress.lastHit($Sprite2D, get_tree())
		queue_free()

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
