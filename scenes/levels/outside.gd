extends LevelParent


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	# diminui a velocidade do jogador para 0 em meio segundo, para ele não andar
	create_tween().tween_property($Player, "speed", 0, .3)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entered() -> void:
	create_tween().tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1).set_trans(Tween.TRANS_QUAD)

func _on_house_player_exited() -> void:
	create_tween().tween_property($Player/Camera2D, "zoom", Vector2(.6,.6), 1)
