extends Area2D

const SPEED = 500
var velocity = Vector2()

onready var player = get_node("../Player");

func _physics_process(delta):
	velocity.y = SPEED * delta
	translate(velocity) 

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Barrel_body_entered(body):
	if "Player" in body.name:
		player.die()
