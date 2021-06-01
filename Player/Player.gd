extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80
var velocity = Vector2.ZERO

enum {
	MOVE,
	ATTACK
}

var state = MOVE

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var _input_vector = Vector2.ZERO
	_input_vector.x = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	_input_vector.y = (Input.get_action_strength("down") - Input.get_action_strength("up"))
	_input_vector = _input_vector.normalized()
	
	if _input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", _input_vector)
		animation_tree.set("parameters/Walk/blend_position", _input_vector)
		animation_state.travel("Walk")
		velocity = velocity.move_toward(MAX_SPEED * _input_vector, delta * ACCELERATION)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

	if Input.is_action_just_pressed("ui_down"):
		state = ATTACK

func attack_state(delta):
	animation_player.play("Atack_Down")
