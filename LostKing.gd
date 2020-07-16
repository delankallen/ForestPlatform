extends KinematicBody2D

const Throwable_PS = preload("res://Throwable.tscn")
var movement = load("res://Movement.gd").new()
onready var throwable_position = $ThrowablePosition

export var lerp_weight = 0.2
export var _height:float = 194
export var _distance:float = 250
export var _speed:float = 300

var GRAVITY = movement.calc_gravity(_speed, _height, _distance)
var FALL_GRAV = movement.calc_gravity(_speed, _height, _distance/1.5)
var facing = 1.0
var throwable = null

var SLOPE_STOP = 64

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

var velocity = Vector2.ZERO
func _physics_process(delta):
	_get_input()
	if velocity.y < 0:
		velocity.y += GRAVITY * delta + (_speed/2*(delta*delta))
	else:
		velocity.y += FALL_GRAV * delta + (_speed/2*(delta*delta))
	
	velocity = move_and_slide(velocity, Vector2.UP, SLOPE_STOP)

func _input(event):
	if event.is_action_pressed("ui_jump") && is_on_floor():
		velocity.y = -movement.initial_velocity(_speed, _height, _distance)
	if event.is_action_pressed("ui_actionX"):
		spawn_throwable()
		if $AnimatedSprite.flip_h == true:
			throwable.launch(_speed*-1)
		else:
			throwable.launch(_speed*1)
		
		throwable = null
		
#func _apply_gravity(delta):
#	if velocity.y < 0:
#		velocity.y += GRAVITY * delta + (_speed/2*(delta*delta))
#	else:
#		velocity.y += FALL_GRAV * delta + (_speed/2*(delta*delta))
	
func _get_input():
	var move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	facing = move_direction
	velocity.x = lerp(velocity.x, _speed * move_direction, lerp_weight)
	if velocity.x != 0:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	if move_direction < 0:
		$AnimatedSprite.flip_h = true;
	elif move_direction > 0:
		$AnimatedSprite.flip_h = false;
		
func spawn_throwable():
	if throwable == null:
		throwable = Throwable_PS.instance()
		$ThrowablePosition.add_child(throwable)

func _on_FallArea_body_entered(_body):
	get_tree().change_scene("res://Level1.tscn")
