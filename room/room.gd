class_name Room
extends Node2D


enum RoomType {
	BATTLE,
	EVENT,
}

enum RoomEvent {
	HEAL,
	INCREASE_HEALTH,
	CHOOSE_CARD,
}


const BAT = preload("res://object/entity/bat/bat.tscn")
const CHOOSE_CARD_SYSTEM = preload("res://room/choose_card_system.tscn")


@export var send_pos := Vector2.ZERO


@onready var choose_card_system_layer: CanvasLayer = $ChooseCardSystemLayer


func choose_card(player: Player):
	choose_card_system_layer.call_deferred("add_child", CHOOSE_CARD_SYSTEM.instantiate())
	

func heal_player(player: Player) -> void:
	player.health = player.max_health


func increase_health(player: Player) -> void:
	player.max_health += 50


func set_send_vector(value: Vector2) -> void:
	send_pos = value


func _on_portal_body_entered(body: Node2D) -> void:
	if body is Player:
		body.position = send_pos


func _on_room_type_setter_body_entered(body: Node2D) -> void:
	if body is Player:
		var room_type = randi_range(0, len(RoomType) - 1)
		if room_type == RoomType.BATTLE:
			var bat: Bat = BAT.instantiate()
			bat.position = Vector2(-300, 0)
			call_deferred("add_child", bat)
		elif room_type == RoomType.EVENT:
			var room_event = RoomEvent.CHOOSE_CARD #randi_range(2, len(RoomEvent) - 1)
			if room_event == RoomEvent.HEAL:
				heal_player(body)
			elif room_event == RoomEvent.INCREASE_HEALTH:
				increase_health(body)
			elif room_event == RoomEvent.CHOOSE_CARD:
				choose_card(body)
		get_node("RoomTypeSetter").queue_free()
