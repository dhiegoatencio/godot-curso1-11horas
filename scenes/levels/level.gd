extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	for scout: ScoutClass in get_tree().get_nodes_in_group('ScoutGroup'):
		scout.laser.connect(_on_scout_laser)
	for container: ItemContainerClass in get_tree().get_nodes_in_group('ContainerGroup'):
		container.open.connect(_on_container_opened)

func _on_scout_laser(pos, direction):
	_create_laser(pos, direction)

func _on_player_laser(pos: Vector2, direction: Vector2) -> void:
	_create_laser(pos, direction)

func _on_container_opened(pos, direction):
	var item: Area2D = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_player_grenade(pos: Vector2, direction: Vector2) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate()
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
func _create_laser(pos, direction):
	var laser: Area2D = laser_scene.instantiate()
	laser.position = pos
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	$Projectiles.add_child(laser)


func _on_player_death() -> void:
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
	Globals.health = 100
	Globals.grenade_amount = 4
	Globals.laser_amount = 10
