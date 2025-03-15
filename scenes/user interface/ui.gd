extends CanvasLayer

# colors
var green: Color = Color('6bbfa3')
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/LaserLabel
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/GrenadeLabel
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/LaserTextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/GrenadeTextureRect
@onready var health_bar: TextureProgressBar = $HealthMarginContainer/HealthTextureProgressBar

func _ready() -> void:
	# Globals.connect("health_change", update_health_text)
	Globals.health_change.connect(update_health_text)
	Globals.grenade_change.connect(update_grenade_text)
	Globals.laser_change.connect(update_laser_text)
	update_grenade_text()
	update_laser_text()
	update_health_text()

func _update_color(amount: int, label: Label, icon: TextureRect) -> void:
	label.text = str(amount)
	var color = green if amount > 0 else red
	label.modulate = color
	icon.modulate = color

func update_laser_text() -> void:
	_update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text() -> void:
	_update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func update_health_text() -> void:
	health_bar.value = Globals.health
