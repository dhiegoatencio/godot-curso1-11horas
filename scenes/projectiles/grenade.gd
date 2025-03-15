extends RigidBody2D

const speed: int = 1200

var insideExplosion1 = []
var insideExplosion2 = []

func _on_explosion_timer_timeout() -> void:
	$AnimationPlayer.play("Explosion")

func _on_explosion_one() -> void:
	damage(insideExplosion1, 30)
	
func _on_explosion_two() -> void:
	damage(insideExplosion2, 60)
	
func _on_explosion_1_area_2d_body_entered(body: Node2D) -> void:
	insideExplosion1.append(body)

func _on_explosion_1_area_2d_body_exited(body: Node2D) -> void:
	insideExplosion1.erase(body)

func damage(bodies, amount: int):
	for body in bodies:
		if 'hit' in body: body.hit(amount)	

func _on_explosion_2_area_2d_body_entered(body: Node2D) -> void:
	insideExplosion2.append(body)

func _on_explosion_2_area_2d_body_exited(body: Node2D) -> void:
	insideExplosion2.erase(body)
