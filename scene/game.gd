extends Node2D


const ROOM = preload("res://room/room.tscn")


# Each room is 1152 * 640
var room_amount = 5
var room_spacing = 800
var portal_spacing = 64 * 9
var map_origin_x = 0
var map_origin_y = 0


@onready var battle: Node2D = $Battle
@onready var battle_camera: Camera2D = $Battle/Camera2D2
@onready var player: Player = $Player
@onready var player_camera: Camera2D = $Player/Camera2D


func _ready():
	switch_default()

	call_deferred("new_rooms")


func getVector(ra):
	var room_vec = Vector2(map_origin_x, map_origin_y + ra * room_spacing)
	return room_vec


func new_rooms() -> void:
	var rooms: Node2D = get_node("Rooms")
	for room in rooms.get_children():
		room.queue_free()
	for i in range(room_amount):
		var room: Room = ROOM.instantiate()
		room.send_pos = getVector(i + 1)
		room.position = getVector(i)
		rooms.add_child(room)


func switch_default():
	battle.set_physics_process(false)
	battle.set_process(false)
	battle_camera.enabled = false
	player.set_physics_process(true)
	player.set_process(true)
	player_camera.enabled = true


func switch_battle():
	player.set_physics_process(false)
	player.set_process(false)
	player_camera.enabled = false
	battle.set_physics_process(true)
	battle.set_process(true)
	battle_camera.enabled = true

	battle.call_deferred("restart")
