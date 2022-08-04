extends Node2D

var health = 50
export(int) var max_health = 50

func _ready():
	health = max_health
	$EnemyHeathbar._enemy_on_max_health_updated(max_health)

func damage(amount):
	health -= amount
	$EnemyHeathbar._enemy_on_health_updated(health)

func _process(_delta):
	if health <= 0:
		get_tree().quit()
