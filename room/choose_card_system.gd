extends Control

@onready var card_base: CardBase = %CardBase
@onready var card_base_1: CardBase = %CardBase1
@onready var card_base_2: CardBase = %CardBase2

# Called when the node enters the scene tree for the first time.
func _ready():
	var chosen_card = randi_range(0, len(CardBase.Card) - 1)
	card_base.card = chosen_card
	chosen_card = randi_range(0, len(CardBase.Card) - 1)
	card_base_1.card = chosen_card
	chosen_card = randi_range(0, len(CardBase.Card) - 1)
	card_base_2.card = chosen_card


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed() -> void:
	queue_free()
