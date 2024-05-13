class_name Bat
extends Entity


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.owner.switch_battle()
		queue_free()
