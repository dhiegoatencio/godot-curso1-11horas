extends ItemContainerClass

func hit(_damage):
	if not opened:
		$LibSprite.hide()
		for i in range(5):
			var SpawPosition: Marker2D = $SpawsPositions.get_child(randi() % $SpawsPositions.get_child_count())
			var pos = SpawPosition.global_position
			open.emit(pos, current_direction)
		opened = true
