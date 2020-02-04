extends Node2D

func _ready():
	$ColorRect/Label.text = "Congratulations!\n Your score: "+str(G.coins)
