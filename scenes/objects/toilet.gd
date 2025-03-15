extends ItemContainerClass

func hit(_damage):
	if not opened: 
		$LibSprite.hide()
		var pos = $SpawsPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
