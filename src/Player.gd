extends CharacterBody2D

class_name Player

signal on_jumped()
signal on_double_jumped()
const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0
var DOUBLE_JUMP_CHECK : bool = true
@onready var sprite_2D : AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	if !velocity.x:
		sprite_2D.play("idle")
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		DOUBLE_JUMP_CHECK = true
	# Handle jump.
	if Input.is_action_just_pressed("player_jump"):
		audio_player.play()
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			on_jumped.emit()
		elif DOUBLE_JUMP_CHECK:
			velocity.y = JUMP_VELOCITY
			DOUBLE_JUMP_CHECK  = false
			on_double_jumped.emit()
	
	if Input.is_action_just_pressed("player_right"):
		sprite_2D.play("run_right")
		sprite_2D.set_flip_h(false)
	elif Input.is_action_just_pressed("player_left"):
		sprite_2D.play("run_right")
		sprite_2D.set_flip_h(true)
	handle_run_animation()
	
	var direction : float = Input.get_axis("player_left", "player_right")
	if Input.is_action_just_pressed("player_dash") and direction:
		velocity.x = direction * SPEED * 10
	elif direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	move_and_slide()

func handle_run_animation() -> void:
	if sprite_2D.animation == "run_right":
		return
	if (
		 Input.is_action_pressed("player_right")
		 and Input.is_action_pressed("player_left")
		 and sprite_2D.animation != "idle"):
			sprite_2D.play("idle")
			return
	elif Input.is_action_pressed("player_right"):
		sprite_2D.play("run_right")
		sprite_2D.set_flip_h(false)
	elif Input.is_action_pressed("player_left"):
		sprite_2D.play("run_right")
		sprite_2D.set_flip_h(true)
	
