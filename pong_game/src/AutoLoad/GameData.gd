extends Node


signal player1_score_update
signal player2_score_update

var player1_score: = 0 setget set_player1_score
var player2_score: = 0 setget set_player2_score

func set_player1_score(value: int):
	player1_score = value
	emit_signal("player1_score_update")

func set_player2_score(value: int):
	player2_score = value
	emit_signal("player2_score_update")
