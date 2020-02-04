extends Node2D

var complete = false

onready var build01 = get_node("Buildings/Build01").get_child(1)
onready var build02 = get_node("Buildings/Build02").get_child(1)
onready var build03 = get_node("Buildings/Build03").get_child(1)

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	G.b1 = rng.randi_range(1, 6)
	G.b2 = rng.randi_range(1, 6)
	G.b3 = rng.randi_range(1, 6)
	build01.play(get_animation(G.b1))
	build02.play(get_animation(G.b2))
	build03.play(get_animation(G.b3))

func get_animation(number: int):
	var anim
	match(number):
		1: anim = "cir_crash"
		2: anim = "kur_crash"
		3: anim = "mus_crash"
		4: anim = "op_crash"
		5: anim = "susu_crash"
		6: anim = "th_crash"
	return anim

func _process(delta):
	$Stats/CanvasLayer/Label.text = str(G.coins)

func complete():
	if G.b1 == 10 && G.b2 == 10 && G.b3 == 10:
		get_tree().change_scene("res://Scenes/End.tscn")
