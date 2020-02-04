extends Area2D

func _on_Ladder_body_entered(body):
	if body.name == "Player":
		get_node("../../Player").ladder_on = true
	if body.name == "Gladiator":
		get_node("../../Gladiator").ladder_on = true

func _on_Ladder_body_exited(body):
	if body.name == "Player":
		get_node("../../Player").ladder_on = false
	if body.name == "Gladiator":
		get_node("../../Gladiator").ladder_on = false
