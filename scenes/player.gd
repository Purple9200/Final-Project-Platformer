extends CharacterBody2D
@export var movement_data : PlayerMovementData
var just_wall_jumped = false
var was_wall_normal = Vector2.ZERO

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var wall_jump_timer = $WallJumpTimer
@onready var animated_sprite_2d = $AnimatedSprite2D

var jump_count = 0
var max_jumps = 1

func _physics_process(delta):
	handle_wall_jump()
	if not is_on_floor():
		velocity.y += gravity * delta

	
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = movement_data.jump_velocity
		jump_count += 1
	if is_on_floor():
		jump_count=0

	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle") 
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * movement_data.speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_data.speed)

	move_and_slide()


func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	var wall_normal = get_wall_normal()
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity
		just_wall_jumped = true
