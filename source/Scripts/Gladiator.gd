extends KinematicBody2D

var SPEED = 170
const FLOOR = Vector2(0, -1)
var GRAVITY = 970
var ladder_on = false

var velocity = Vector2()
var direction = 1

var timer = null
var barrel_attack = null
var patrol_time = 6

onready var player = get_node("../Player");
var lets_go = false
var game_over = false

var rng = RandomNumberGenerator.new()
const BARREL = preload("res://Scenes/Barrel.tscn") 

func _ready():
	timer = Timer.new()
	timer.set_wait_time(patrol_time)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
	barrel_attack = Timer.new()
	barrel_attack.connect("timeout", self, "on_barrel_attack")
	add_child(barrel_attack)
	barrel_attack.start()

func _physics_process(delta):
	if player.position.y < 350:
		lets_go = true
	if lets_go:
		SPEED = 120
		timer.stop()
		barrel_attack.stop()
		attack_mode()
	else:
		rng.randomize()
		var number = rng.randf_range(0.5, 1.5)
		barrel_attack.set_wait_time(number)
	velocity.x = SPEED * direction
	if !game_over:
		$AnimatedSprite.play("walk")
	if ladder_on:
		GRAVITY = 0
		if lets_go:
			if position.y + 37 <= player.position.y:
				velocity.y = SPEED
			elif position.y + 37 > player.position.y:
				velocity.y = -SPEED
			else:
				velocity.y = 0
	else:
		GRAVITY = 970
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)

func on_timeout_complete():
	attack_mode()

func on_barrel_attack():
	var barrel = BARREL.instance()
	barrel.position = $Position2D.global_position
	get_parent().add_child(barrel)

func attack_mode():
	if lets_go:
		if !player.position.y-position.y > 40 and position.y < player.position.y:
			if position.x > player.position.x:
				direction = -1
				$AnimatedSprite.flip_h = true
			elif position.x < player.position.x:
				direction = 1
				$AnimatedSprite.flip_h = false
		if is_on_wall() and !ladder_on:
			change_direction()
		else:
			velocity.x = 0
	else:
		change_direction()

func change_direction():
	direction *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		game_over = true
		$AnimatedSprite.play("attack")
	
func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "attack"):
		game_over = false
		player.die()
