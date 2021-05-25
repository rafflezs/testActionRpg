extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 95
var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	
	var _input_vector = Vector2.ZERO
	_input_vector.x = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	_input_vector.y = (Input.get_action_strength("down") - Input.get_action_strength("up"))
	_input_vector = _input_vector.normalized()
	
	if _input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * _input_vector, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - self.position).normalized()
	var new_angle = PI + atan2(direction.y, direction.x)
	self.rotation = new_angle
	
	$Sprite.look_at(get_global_mouse_position())
	$Sprite.rotation -= PI
	$Sprite.rotation = new_angle
