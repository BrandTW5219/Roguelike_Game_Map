class_name Player
extends Entity

@export var max_health := 100
@export var health := 100
@export var attack_power := 100
var cards := []

@onready var image = $Image as Sprite2D
@onready var hit_box = $HitBox
@onready var running_audio_player: AudioStreamPlayer = $RunningAudioPlayer


func _ready():
	add_to_group("PLAYER")

func _physics_process(delta):
	super._physics_process(delta)
	if velocity.x > 0:
		image.flip_h = false
	elif velocity.x < 0:
		image.flip_h = true

func get_direction() -> Vector2:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO and running_audio_player.playing:
		running_audio_player.playing = false
	elif direction != Vector2.ZERO and not running_audio_player.playing:
		running_audio_player.playing = true
	return direction
	


