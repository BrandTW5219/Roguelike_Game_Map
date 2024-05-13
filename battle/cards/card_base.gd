@tool 
class_name CardBase
extends Control


enum Card{
	DILUTED_HEALTH_POTION,
	OLD_WHETSTONE,
	WEAK_SENSE_OF_DEFENSE,
}


const CARD_BASE_PATH = "res://battle/cards/"


@export var card := Card.DILUTED_HEALTH_POTION:
	set(value):
		card = value
		should_init = true

var should_init := true

var base_pos := Vector2(0, 0):
	set(value):
		position = value
		base_pos = value
# 用於紀錄滑鼠是否在物件內
var is_mouse_entered = false
# 用於判斷滑鼠左鍵長按時是否在物件範圍內
var is_mouse_left_just_pressed = false
# 紀錄在物件範圍內左鍵長按時的滑鼠座標
var mouse_left_just_pressed_pos


var _card_name_dict = {
	Card.DILUTED_HEALTH_POTION: "DILUTED_HEALTH_POTION",
	Card.OLD_WHETSTONE: "OLD_WHETSTONE",
	Card.WEAK_SENSE_OF_DEFENSE: "WEAK_SENSE_OF_DEFENSE",
}


@onready var collision_shape_2d = $Image/Area2D/CollisionShape2D as CollisionShape2D
@onready var image = $Image
@onready var context_label = $ContextLabel


func _ready():
	pass


func _process(delta):
	if should_init:
		should_init = false
		var image_path = CARD_BASE_PATH + _card_name_dict[card] + "/image.png"
		var context_path = CARD_BASE_PATH + _card_name_dict[card] + "/context.txt"
	
		image.texture = ImageTexture.create_from_image(
			Image.load_from_file(image_path)
		)
		context_label.text = FileAccess.get_file_as_string(context_path)
	
	# 判斷是否在物件範圍內長按滑鼠左鍵
	# 如果是則紀錄滑鼠座標
	if is_mouse_entered and !is_mouse_left_just_pressed and Input.is_action_just_pressed("mouse_left"):
		mouse_left_just_pressed_pos = get_global_mouse_position()
		is_mouse_left_just_pressed = true
	
	# 判斷是否一直長按
	if is_mouse_left_just_pressed:
		position = base_pos - mouse_left_just_pressed_pos + get_global_mouse_position()

	# 判斷滑鼠左鍵是否放開
	if is_mouse_left_just_pressed and Input.is_action_just_released("mouse_left"):
		if base_pos.y - position.y  >= collision_shape_2d.shape.size.y:
			queue_free()
		position = base_pos
		is_mouse_left_just_pressed = false


func _on_mouse_entered():
	is_mouse_entered = true


func _on_mouse_exited():
	is_mouse_entered =false
