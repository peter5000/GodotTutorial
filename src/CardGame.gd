extends Node2D

var card_scene = load("res://src/Card.tscn")
var player_scene = load("res://src/Player.tscn")
var enemy_scene = load("res://src/Enemy.tscn")
var cards = []
var selected_card = null
var starting_cards = 6
var player_child = null
var enemy_child = null

func _ready():
	randomize()
	var screen_size = get_viewport_rect().size
	for i in range(starting_cards):
		var card = card_scene.instance()
		card.position = Vector2((screen_size.x-starting_cards*150)/2+i*150 , screen_size.y -220)
		add_child(card)
		cards.append(card)
	var player = player_scene.instance()
	player.position = Vector2(150,50)
	add_child(player)
	player_child = player
	var enemy = enemy_scene.instance()
	enemy.position = Vector2(700,50)
	add_child(enemy)
	enemy_child = enemy
	enemy.damage(0)

func _input(event):
	if event is InputEventMouse:
		var hover = false
		for i in range(cards.size()-1,-1,-1):
			if cards[i] == selected_card:
				cards[i].scale=Vector2(1.2,1.2)
			else:
				var card_sprite = cards[i].get_node("CardSprite")
				if !hover and card_sprite.get_rect().has_point(card_sprite.get_local_mouse_position()):
					if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
						selected_card=cards[i]
						cards.remove(i)
					else:
						cards[i].scale = Vector2(1.2,1.2)
						hover = true
				else:
					cards[i].scale=Vector2(1,1)
	if selected_card != null:
		enemy_child.damage(int(selected_card.get_node("Label").text))
		remove_child(selected_card)
		selected_card = null
	
func _process(_delta):
	var screen_size = get_viewport_rect().size
	for i in range(cards.size()):
		var card = cards[i]
		card.position = Vector2((screen_size.x-cards.size()*150)/2+i*150 , screen_size.y -220)
	if cards.size() == 0:
		player_child.damage(randi()%40+10)
		for i in range(starting_cards):
			var card = card_scene.instance()
			card.position = Vector2((screen_size.x-starting_cards*150)/2+i*150 , screen_size.y -220)
			add_child(card)
			cards.append(card)
