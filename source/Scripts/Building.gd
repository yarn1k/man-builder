extends Area2D

onready var player = get_node("../../Player")

var state = 0
var entered = false

var num_b

func repair_process():
	if entered && player.repair_process:
		state = state + 1
		match G.build:
			1: num_b = G.b1
			2: num_b = G.b2
			3: num_b = G.b3
		match state:
			1: $AnimatedSprite.play(get_animation(num_b, 3), true)
			2: $AnimatedSprite.play(get_animation(num_b, 2), true)
			3: 
				$AnimatedSprite.play(get_animation(num_b, 1), true)
				match G.build:
					1: G.b1 = 10
					2: G.b2 = 10
					3: G.b3 = 10

func get_animation(num_build: int, rep: int):
	var anim
	match num_build:
		1: anim = "cir_repair0"+str(rep)
		2: anim = "kur_repair0"+str(rep)
		3: anim = "mus_repair0"+str(rep)
		4: anim = "op_repair0"+str(rep)
		5: anim = "susu_repair0"+str(rep)
		6: anim = "th_repair0"+str(rep)
	return anim

func _on_Building_body_entered(body):
	if body.name == "Player":
		entered = true
		match name:
			"Build01": G.build = 1
			"Build02": G.build = 2
			"Build03": G.build = 3

func _on_Building_body_exited(body):
	entered = false
