# 使用方法為繼承
class_name Entity
extends CharacterBody2D


enum Type {
	PLAYER,
	ENEMY,
}


# 類型
@export var type : Type

@export_group("Movement")
# 加速度
@export_range(1, 1000, 1, "or_greater") var acceleration := 1000
# 摩擦力(減速)
@export_range(1, 1000, 1, "or_greater") var friction := 800
# 最大速度
@export_range(0, 1000, 1, "or_greater") var max_speed := 400


func _physics_process(delta: float):
	# 移動方向
	var direction = get_direction()
	
	# 移動時速度依據加速度遞增
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(
				direction.normalized() * max_speed,
				acceleration * delta
		)
	# 否則以摩擦力遞減
	else:
		velocity = velocity.move_toward(
				Vector2.ZERO,
				friction * delta
		)
	
	# 移動
	move_and_slide()


# 獲取移動方向
# 預設不動
# override 製作移動ai
func get_direction() -> Vector2:
	return Vector2.ZERO
