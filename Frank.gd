extends KinematicBody2D
export var lerp_weight = 0.2
export var _distance:float = 192
export var _height:float = 176
export var _speed:float = 300
export var speed = 475
var screen_size
var movement = load("res://Movement.gd").new()
var GRAVITY = movement.calc_gravity(_speed, _height, _distance)

var velocity = Vector2(0,0)
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = _speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -_speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
	
	if not is_on_floor():
		$AnimatedSprite.play("jump")
		
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = -movement.initial_velocity(_speed, _height, _distance)
	if velocity.y < 0:
		velocity.y += GRAVITY * delta + (_speed/2*(delta*delta))
	else:
		velocity.y += movement.calc_gravity(_speed, _height, _distance/1.75) * delta + (_speed/2*(delta*delta))
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, lerp_weight)


func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")
