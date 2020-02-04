extends Node2D

func _on_Button_pressed():
	G.coins = 0
	get_tree().change_scene("res://Scenes/Menu.tscn")
