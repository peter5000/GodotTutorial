extends Control

onready var health_bar = $PlayerHealthbar
	
func _player_on_health_updated(health):
	health_bar.value = health
	
func _player_on_max_health_updated(max_health):
	health_bar.max_value = max_health
