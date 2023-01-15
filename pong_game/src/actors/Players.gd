extends KinematicBody2D

onready var label: Label = $CanvasLayer/Label
onready var color_rect: ColorRect = $ColorRect
onready var which_player: = check_player(is_player_1)

export var speed: = Vector2(0.0, 500.0)
export var is_player_1: = true

var _velocity: = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP
var player1_color: = Color(1, 0, 0, 1)
var player2_color: = Color(0, 0, 1, 1)



func _ready():
	change_color()
	
func change_color():
	match is_player_1:
		true:
			color_rect.color = player1_color
		_:
			color_rect.color = player2_color

# Runs every frame
func _physics_process(delta):
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	is_player_1 = switch_player(is_player_1)
#	change_color()

#Check what player this actor is
func check_player(player_number: bool) -> String:
	match player_number:
		true:
			return "Player1"
		_:
			return "Player2"

#Press K to switch player for Debugging
func switch_player(player: bool) -> bool:
	if Input.is_action_just_released("switch_player"):
		player = !player
		print("changed player control")
	return player

#Calculate velocity to go up or down, depending on input
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var out = linear_velocity
	out.y = speed.y * direction.y
	return out

#Check direction based on input
func get_direction() -> Vector2:
	var player_move_up: = "%s_move_up" % which_player
	var player_move_down: = "%s_move_down" % which_player
	return Vector2(
		0.0,
		 Input.get_action_strength(player_move_down) - Input.get_action_strength(player_move_up)
	)
