extends Node
class_name Movement

#export var lerp_weight = 0.2
#export var _distance:float = 192
#export var _height:float = 184

#var time:float = _distance / _speed
#var vertex:float = 4*_height/(time*time)
#var jump_force = vertex * time
#var GRAVITY = 2*vertex 
#var facing = -_speed
#var screen_size

func calc_gravity(lateral_speed, height, distance):
	var _distance_to_peak = distance/2.0
	var gravity = (2.0 * height * (lateral_speed * lateral_speed))/(_distance_to_peak*_distance_to_peak)
	return gravity

func initial_velocity(lateral_speed, height, distance):
	var _distance_to_peak = distance/2.0
	var velocity = (2.0 * height * lateral_speed) / _distance_to_peak
	return velocity
