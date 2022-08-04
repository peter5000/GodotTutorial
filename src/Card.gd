extends Node2D

func _ready():
	$Label.text = str(randi()%9+1)
