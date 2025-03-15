extends Node

static func hit(sprite2D: Sprite2D, tree: SceneTree):
	on(0.5, 0.005, sprite2D, tree)

static func lastHit(sprite2D: Sprite2D, tree: SceneTree):
	await on(1.0, 0.1, sprite2D, tree)

static func on(max_progress: float, timer: float, sprite2D: Sprite2D, tree: SceneTree):
	var progress = 0.1 # começa 0.1
	while progress <= max_progress:
		if sprite2D: _setProgress(sprite2D, progress)
		progress += 0.1 # incrementa o proximo tick
		await tree.create_timer(timer).timeout # espera 0.1s
		if sprite2D: _setProgress(sprite2D, 0)

static func _setProgress(sprite2D: Sprite2D, progress: float):
	if 'material' in sprite2D:
		sprite2D.set_instance_shader_parameter('progress', progress)
