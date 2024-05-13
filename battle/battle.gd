extends Node2D


const BALL = preload("res://battle/balls/ball.tscn")
const CARD_SCENE = preload("res://battle/cards/card_base.tscn")


@onready var balls: Node2D = $Battle/Balls
@onready var cards = $Cards
@onready var start_button: Button = $StartButton
@onready var ball_stop_checker: Timer = $BallStopChecker


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var card = CARD_SCENE.instantiate()
		card.card = randi_range(0, len(CardBase.Card) - 1)
		cards.add_child(card)


func check_gameover():
	var player_flag = false
	var enemy_flag = false
	for ball in balls.get_children():
		player_flag = player_flag or ball.type == Ball.Type.PLAYER
		enemy_flag = enemy_flag or ball.type == Ball.Type.ENEMY
	if not player_flag:
		print("lose")
	elif not enemy_flag:
		print("win")
		owner.call_deferred("switch_default")


func restart():
	for child in balls.get_children():
		child.queue_free()
	for child in cards.get_children():
		child.queue_free()

	var player_ball = BALL.instantiate() as Ball
	player_ball.type = Ball.Type.PLAYER
	player_ball.position = Vector2(-400, 0)
	
	var enemy_ball = BALL.instantiate() as Ball
	enemy_ball.position = Vector2(400, 0)
	enemy_ball.max_health = 5
	enemy_ball.health = 5
	
	balls.add_child(player_ball)
	balls.add_child(enemy_ball)


func _on_start_button_button_down() -> void:
	start_button.disabled = true
	ball_stop_checker.start()
	
	for ball in balls.get_children():
		ball.ball_run()


func _on_ball_stop_checker_timeout() -> void:
	for ball in balls.get_children():
		if ball.linear_velocity != Vector2.ZERO:
			return
	ball_stop_checker.stop()
	start_button.disabled = false
	
	check_gameover()
