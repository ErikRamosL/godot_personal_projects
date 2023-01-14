extends KinematicBody2D

onready var label: Label = $CanvasLayer/Label

export var speed: = Vector2(0.0, 500.0)
export var is_player_1: = true

var _velocity: = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP

#func _ready():

func check_player(player_number: bool) -> int:
	match player_number:
		true:
			return 1
		_:
			return 2

func _physics_process(delta):
#	label.text = which_player as String
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	is_player_1 = switch_player(is_player_1)

func switch_player(player: bool) -> bool:
	if Input.is_action_just_released("switch_player"):
		player = !player
	return player

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var out = linear_velocity
	out.y = speed.y * direction.y
	return out

func get_direction() -> Vector2:
	var which_player: = check_player(is_player_1)
	var player_move_up: = "Player%s_move_up" % which_player
	var player_move_down: = "Player%s_move_down" % which_player
	return Vector2(
		0.0,
		 Input.get_action_strength(player_move_down) - Input.get_action_strength(player_move_up)
	)
