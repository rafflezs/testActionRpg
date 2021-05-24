extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 100
var velocity = Vector2.ZERO

func _physics_process(delta):
	
	var _input_vector = Vector2.ZERO
	_input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	_input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	_input_vector = _input_vector.normalized()
	
	if _input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * _input_vector, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
