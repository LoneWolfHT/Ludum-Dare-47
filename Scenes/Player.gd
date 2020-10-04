extends KinematicBody2D

export (float) var GRAVITY = 980
export (int) var WALK_SPEED = 300
export (int) var JUMP_VEL = 500
export (bool) var CAN_MOVE = true
export (int) var INITIAL_ROTATION_SPEED = 5

var ROTATION_SPEED = INITIAL_ROTATION_SPEED
var velocity = Vector2()
var JUMPS_LEFT = 0

func _physics_process(delta):
	var floor_dir = Vector2(0, -1).rotated(deg2rad(rotation_degrees))

	velocity.y += GRAVITY * delta

	velocity = velocity.clamped(GRAVITY * 3)

	if position.y >= 3000 or position.y <= -3000 or position.x >= 4000 or position.x <= -4000: # Player fell off
		get_tree().reload_current_scene()

	if is_on_floor() or is_on_ceiling():
		velocity = move_and_slide(velocity, floor_dir, true)
	else:
		velocity.x = move_and_slide(velocity, floor_dir, true).x

	if CAN_MOVE:
		if Input.is_action_just_pressed("rotate_right") and ROTATION_SPEED <= 90:
			ROTATION_SPEED += 30

			if ROTATION_SPEED == 0:
				ROTATION_SPEED += INITIAL_ROTATION_SPEED
		elif Input.is_action_just_pressed("rotate_left") and ROTATION_SPEED >= -90:
			ROTATION_SPEED -= 30

			if ROTATION_SPEED == 0:
				ROTATION_SPEED -= INITIAL_ROTATION_SPEED
		get_parent().get_node("TileMap").rotation_degrees += ROTATION_SPEED * delta

		_handle_anims()

		if Input.is_action_pressed("left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("right"):
			velocity.x = WALK_SPEED
		else:
			velocity.x = 0

		if is_on_floor():
			JUMPS_LEFT = 2
		elif JUMPS_LEFT == 2:
			JUMPS_LEFT = 1

		if Input.is_action_just_pressed("up") and JUMPS_LEFT - 1 >= 0:
			JUMPS_LEFT -= 1
			velocity.y = -JUMP_VEL

func _handle_anims():
	if Input.is_action_pressed("left"):
		get_node("Anim").animation = "Walk"
		get_node("Anim").flip_h = false
	elif Input.is_action_pressed("right"):
		get_node("Anim").animation = "Walk"
		get_node("Anim").flip_h = true
	else:
		get_node("Anim").animation = "Idle"
		get_node("Anim").flip_h = false

