extends KinematicBody2D

export (float) var GRAVITY = 980
export (int) var WALK_SPEED = 300
export (int) var JUMP_VEL = 500
export (bool) var CAN_MOVE = true
export (bool) var CAN_ROTATE = true

const ROTATION_STEP = 25
const INITIAL_ROTATION_SPEED = 25
var ROTATION_SPEED = INITIAL_ROTATION_SPEED
var velocity = Vector2()
var JUMPS_LEFT = 0

func _ready():
	if CAN_ROTATE:
		get_node("/root/Music/BeatRight").playing = true
		get_node("/root/Music/BeatLeft").playing = false

func _physics_process(delta):
	var floor_dir = Vector2(0, -1).rotated(deg2rad(rotation_degrees))

	velocity.y += GRAVITY * delta

	velocity = velocity.clamped(GRAVITY * 3)

	if position.y >= 3000 or position.y <= -3000 or position.x >= 4000 or position.x <= -4000: # Player fell off
		get_tree().reload_current_scene()

	if is_on_floor() or is_on_ceiling():
		velocity = move_and_slide(velocity, Vector2(0, -1), true)
	else:
		velocity.x = move_and_slide(velocity, Vector2(0, -1), true).x

	if CAN_MOVE:
		if CAN_ROTATE:
			if Input.is_action_just_pressed("rotate_right") and ROTATION_SPEED <= ROTATION_STEP*3:
				ROTATION_SPEED += ROTATION_STEP

				if ROTATION_SPEED == 0:
					ROTATION_SPEED += INITIAL_ROTATION_SPEED
					get_node("/root/Music/BeatRight").playing = true
					get_node("/root/Music/BeatLeft").playing = false
			elif Input.is_action_just_pressed("rotate_left") and ROTATION_SPEED >= -ROTATION_STEP*3:
				ROTATION_SPEED -= ROTATION_STEP

				if ROTATION_SPEED == 0:
					ROTATION_SPEED -= INITIAL_ROTATION_SPEED
					get_node("/root/Music/BeatLeft").playing = true
					get_node("/root/Music/BeatRight").playing = false

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
	elif not is_on_floor():
		get_node("Anim").animation = "Fall"
		get_node("Anim").flip_h = false
	else:
		get_node("Anim").animation = "Idle"
		get_node("Anim").flip_h = false

