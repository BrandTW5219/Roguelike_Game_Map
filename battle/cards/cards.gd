extends Control


func set_children_pos():
	var children: Array[CardBase] = []
	children.append_array(get_children())
	
	var card_length = children.size()
	if card_length == 0:
		return
	var card_width = children[0].size.x
	var width_sum = card_length * card_width
	
	var card_gap = card_width
	if width_sum > size.x:
		card_gap -= (width_sum - size.x) / (card_length - 1)
		width_sum = size.x
	
	var start_x = size.x / 2 - width_sum / 2
	
	for i in range(card_length):
		children[i].base_pos = Vector2(start_x + card_gap * i, 0)


func _on_child_order_changed():
	set_children_pos()
