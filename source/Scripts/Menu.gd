extends Control

func _on_But01_pressed():
	get_tree().change_scene("res://Scenes/Level01.tscn")

func _on_But02_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_But03_pressed():
	get_tree().quit()
