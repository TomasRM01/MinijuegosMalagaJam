extends Node

signal timer_ended
signal metronome_ended # For points
signal submetronome_ended # For animations

@onready var minigame_timer: Timer = $MinigameTimer
@onready var metronome_timer: Timer = $MetronomeTimer
@onready var submetronome_timer: Timer = $SubMetronomeTimer


var rhythm_points_array: Array[float] = [-1.0, -1.0, -1.0, -1.0]
var is_step_taken_array: Array[float] = [false, false, false, false]
var players_ids_array: Array[int]
var steps_to_take
var time_between_steps
var steps_taken = 0
# in seconds, this is the window of time that the players have to count the entry
var success_delay = 0.3
# in seconds, this is used to play the animations before the input window closes
var calibration_delay = 0.2

func _ready() -> void:
	minigame_timer.timeout.connect(_on_timer_ended)


func setup_minigame(minigame_time, players_ids, number_of_steps) -> void:
	#TODO countdown with rhythm (1, 2, 3, and!)
	players_ids_array = players_ids
	_setup_array(players_ids)
	_setup_metronome(minigame_time, number_of_steps)
	_setup_timer(minigame_time)


func _setup_timer(minigame_time) -> void:
	minigame_timer.wait_time = minigame_time
	minigame_timer.start()


func _setup_array(players_ids) -> void:
	for player_id in players_ids:
		rhythm_points_array[player_id] = 0.0


func _setup_metronome(minigame_time, number_of_steps) -> void:
	steps_to_take = number_of_steps
	time_between_steps = minigame_time / (number_of_steps + 1)
	metronome_timer.wait_time = time_between_steps
	metronome_timer.timeout.connect(_on_metronome_timeout)
	metronome_timer.start()
	submetronome_timer.wait_time = time_between_steps - calibration_delay
	submetronome_timer.timeout.connect(_on_submetronome_timeout)
	submetronome_timer.start()


func _on_submetronome_timeout() -> void:
	submetronome_ended.emit()


func _on_metronome_timeout() -> void:
	for player_id in players_ids_array:
		if !is_step_taken_array[player_id]:
			_player_failed_step(player_id, false)
		is_step_taken_array[player_id] = false
	metronome_ended.emit()
	steps_taken += 1
	print("this is the " + str(steps_taken) + " step")
	if steps_taken == steps_to_take:
		metronome_timer.stop()
	else:
		submetronome_timer.start()


func _on_timer_ended() -> void:
	var winner = _get_winner()
	#TODO small animation with winner
	timer_ended.emit(winner)


func on_player_pressed(player_id) -> void:
	if metronome_timer.is_stopped(): # do not count input if the minigame is not running
		return
	
	if is_step_taken_array[player_id]: # fail automatically if spammer
		_player_failed_step(player_id, true)
		return
	
	is_step_taken_array[player_id] = true
	
	print("player " + str(player_id) + " pressed with " + str(metronome_timer.time_left) + " time left")
	if metronome_timer.time_left < success_delay:
		if metronome_timer.time_left <= 0.2:
			print("player " + str(player_id) + " PERFECT!!!")
			rhythm_points_array[player_id] += time_between_steps * 2
		else:
			print("player " + str(player_id) + " success!")
			rhythm_points_array[player_id] += time_between_steps - metronome_timer.time_left
	else:
		_player_failed_step(player_id, true)



func _player_failed_step(player_id, is_from_input) -> void:
	if is_from_input:
		print(str(player_id) + " failure, too soon") # when the player makes an input and fails, always collides with next
	else:
		print(str(player_id) + " failure, too late") # when the player doesn't press on time


func _get_winner() -> int:
	var winners = []
	var player = 0
	for rhythm_points in rhythm_points_array:
		if rhythm_points == rhythm_points_array.max():
			winners.append(player)
		player += 1
	
	# Just in case there is a draw, the winner is randomly chosen
	return winners.get(randi_range(0, winners.size() - 1))
