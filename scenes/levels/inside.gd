extends LevelParent

func _ready() -> void:
	$DirectionalLight2D.visible = true
	super()

func _on_exit_game_area_body_entered(_body: Node2D) -> void:
	# diminui a velocidade do jogador para 0 em meio segundo, para ele não andar
	create_tween().tween_property($Player, "speed", 0, .51)
	# get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
