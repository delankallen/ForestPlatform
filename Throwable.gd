extends KinematicBody2D

export var lerp_weight = 0.2
export var _distance:float = 380
export var _height:float = 140
export var _speed:float = 600
var time:float = _distance / _speed
var vertex:float = 4*_height/(time*time)
var jump_force = vertex * time
var GRAVITY = 2*vertex
var screen_size
var firstTime = true

var velocity = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)	
	if collision != null:
		velocity = Vector2.ZERO
		_on_impact(collision.normal)
	else:
		velocity.y += GRAVITY * delta

func launch(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
#	if direction > 0:
#		direction /= direction
#	else:
#		direction /= -direction
	velocity = Vector2(direction*1.65, -jump_force)
	set_physics_process(true)

func _on_impact(normal : Vector2):
	$AnimatedSprite.position.y = -28
	$AnimatedSprite.play("contact")
	if firstTime == true:
		$Light2D.energy = 2.0
		$Light2D.scale = Vector2(.5,.5)
		firstTime = false
	$Light2D.energy = lerp($Light2D.energy, 0.0, 0.02)

func _on_AnimatedSprite_animation_finished():
	var ani_name = $AnimatedSprite.animation.get_basename()
	if ani_name == "contact":
		firstTime == true
		get_parent().remove_child(self)
