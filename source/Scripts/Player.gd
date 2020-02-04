extends KinematicBody2D

const SPEED = 150
const FLOOR = Vector2(0, -1)
var GRAVITY = 970
const JUMP_POWER = -250
var ladder_on = false
var repair_process = false

var velocity = Vector2()
var timer = null

var is_dead = false

onready var build01 = get_node("../Buildings/Build01")
onready var build02 = get_node("../Buildings/Build02")
onready var build03 = get_node("../Buildings/Build03")

func add_coin():
	G.coins += 1

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	is_dead = true

func _physics_process(delta):
	if position.y > 800:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	if !repair_process && Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("walk")
	elif !repair_process && Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			$AnimatedSprite.play("walk")
	else:
		velocity.x = 0
		if !repair_process and is_on_floor():
			$AnimatedSprite.play("idle")

	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = JUMP_POWER
		$AnimatedSprite.play("jump")

	if Input.is_action_just_pressed("ui_repair") && is_on_floor():
		$AnimatedSprite.play("repair")
		repair_process = true

	if ladder_on:
		GRAVITY = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED
		else:
			velocity.y = 0
	else:
		GRAVITY = 970

	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)

func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "repair"):
		velocity.x = 0
		match(G.build):
			1: build01.repair_process()
			2: build02.repair_process()
			3: build03.repair_process()
		repair_process = false
		get_node("../../Level01").complete()
