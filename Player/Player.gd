extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80
var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _physics_process(delta):
	
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
