extends CharacterBody2D


const SPEED = 400.0

# copied from https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()
